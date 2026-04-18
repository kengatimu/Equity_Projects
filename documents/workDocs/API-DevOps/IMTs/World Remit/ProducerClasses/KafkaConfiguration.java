package com.equitybank.imt.worldremit.producer.messaging;

import com.equitybank.imt.worldremit.producer.models.domain.Transaction;
import com.equitybank.imt.worldremit.producer.models.http.requests.TransactionChangeStatus;
import com.equitybank.imt.worldremit.producer.models.repository.TransactionDataRepository;
import com.equitybank.imt.worldremit.producer.retrofit.ConsumerService;
import com.equitybank.imt.worldremit.producer.retrofit.WRService;
import com.equitybank.imt.worldremit.producer.retrofit.WRServiceGenerator;
import com.equitybank.imt.worldremit.producer.models.http.PropertiesMap;
import com.google.gson.Gson;
import com.microsoft.applicationinsights.TelemetryClient;
import com.microsoft.applicationinsights.telemetry.SeverityLevel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.SimpleAsyncTaskExecutor;
import org.springframework.core.task.TaskExecutor;
import org.springframework.kafka.annotation.EnableKafka;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.listener.DeadLetterPublishingRecoverer;
import org.springframework.kafka.listener.SeekToCurrentErrorHandler;
import org.springframework.kafka.support.converter.RecordMessageConverter;
import org.springframework.kafka.support.converter.StringJsonMessageConverter;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.util.backoff.FixedBackOff;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

import java.util.Map;
import java.util.Optional;

@Configuration
@Slf4j
@EnableKafka
public class KafkaConfiguration {

    // passing the token which you set in application.properties
    @Value("${app.token}")
    private String token;

    @Bean
    public WRService wrService() {
        return WRServiceGenerator.createService(WRService.class, token);
    }

    @Bean
    ConsumerService consumerService() {
        return WRServiceGenerator.createService(ConsumerService.class);
    }

    private final TaskExecutor exec = new SimpleAsyncTaskExecutor();

    @Bean
    public SeekToCurrentErrorHandler errorHandler(KafkaTemplate<Object, Object> template) {
        return new SeekToCurrentErrorHandler(
                new DeadLetterPublishingRecoverer(template), new FixedBackOff(1000L, 2));
    }

    @Bean
    public RecordMessageConverter converter() {
        return new StringJsonMessageConverter();
    }

    @Autowired
    TransactionDataRepository transactionDataRepository;

    @Autowired
    TelemetryClient telemetryClient;
    
    @KafkaListener(id = "transactionGroup", topics = "transactionEnd")
    public void listen(@Payload Map<String, String> response) {
        Gson gson = new Gson();
//        log.info("response:::::::: " + response);
        log.info("response from consumer: ".toUpperCase() + gson.toJson(response)); 
        this.exec.execute(() -> {
            //completing transaction
            String wrid = response.get("paymentReference1");
            Optional<Transaction> optionalTransaction = transactionDataRepository.findByWorldRemitId(wrid);
            String status = response.get("status");
            if (optionalTransaction.isPresent()) {
                Transaction transaction = optionalTransaction.get();
                String reference = transaction.getReference();
                if (status.equalsIgnoreCase("Success")) {
                    transaction.setStatus("Success");
                    transaction.setMessage("Transaction completed successfully");
                    //send setPaid to wr
                    wrService().setTransactionPaid(transaction.getWrid(), transaction.getReference()).enqueue(new Callback<Void>() {
                        @Override
                        public void onResponse(Call<Void> call, Response<Void> response) {
                            log.info("PAID SUCCESS STATUS {} ", response.code());
                            telemetryClient.trackTrace("PAID SUCCESS STATUS: " + response.code(), SeverityLevel.Information);
                            transactionDataRepository.save(transaction);
                        }

                        @Override
                        public void onFailure(Call<Void> call, Throwable throwable) {
                            log.info("PAID FAILED ERROR {} ", throwable.getMessage());
                            telemetryClient.trackTrace("PAID FAILED ERROR: " + throwable.getMessage(), SeverityLevel.Information);
                        }
                    });

                } else if (response.get("responsecode").equalsIgnoreCase("0036")) {

                    TransactionChangeStatus transactionChangeStatus = new TransactionChangeStatus();
                    transactionChangeStatus.setResponseCode("0036");
                    transactionChangeStatus.setResponseMessage("Success");
                    transactionChangeStatus.setTxnReference(transaction.getWrid());
                    PropertiesMap map = new PropertiesMap();

                    transactionChangeStatus.setResponseCode("0036");
                    map.addProperty("responsecode", "0036");
                    map.addProperty("responsemessage", "Transaction Acknowledged");
                    map.addProperty("mycustom1", "Transaction with Reference ID [" + reference + "] is being processed ");
                    transactionChangeStatus.setProperties(map);
                    wrService().setTransactionAcknowledged(transaction.getWrid(), transaction.getWrid(), transactionChangeStatus).enqueue(new Callback<Void>() {
                        @Override
                        public void onResponse(Call<Void> call, Response<Void> response) {
                            log.info("ACKNOWLEDGE STATUS {}", response.code());
                            transaction.setMessage("ACKNOWLEDGEMENT COMPLETE [ message = " + response.body() + "]");
                            transaction.setStatus("ACKNOWLEDGED" + response.code());
                            telemetryClient.trackTrace("ACKNOWLEDGE STATUS: " + response.code(), SeverityLevel.Information);
                            transactionDataRepository.save(transaction);
                        }

                        @Override
                        public void onFailure(Call<Void> call, Throwable throwable) {
                            transaction.setStatus("ACKNOWLEDGED " + throwable.getMessage());
                            transaction.setMessage("ACKNOWLEDGEMENT FAILED");
                            log.info("ACKNOWLEDGE ERROR {}", throwable.getMessage());
                            telemetryClient.trackTrace("ACKNOWLEDGE ERROR: " + throwable.getMessage(), SeverityLevel.Information);
                            transactionDataRepository.save(transaction);
                        }
                    });

                } else {
                    transaction.setStatus("Failed");
                    transaction.setMessage("Transaction failed reason " + response.get("responsemsg"));
                    PropertiesMap properties = new PropertiesMap();
                    properties.addProperty("responsecode", response.get("responsecode"));
                    properties.addProperty("responsemessage", response.get("responsemsg"));
                    properties.addProperty("txnreference", transaction.getWrid());
                    properties.addProperty("mycustom1", response.get("responsemsg"));
                    TransactionChangeStatus transactionChangeStatus = new TransactionChangeStatus();
                    transactionChangeStatus.setProperties(properties);
                    wrService().setTransactionFailed(transaction.getWrid(), transaction.getReference(), transactionChangeStatus).enqueue(new Callback<Void>() {
                        @Override
                        public void onResponse(Call<Void> call, Response<Void> response) {
                            log.info("PAID FAILED STATUS {} ", response.code());
                            telemetryClient.trackTrace("PAID FAILED STATUS: " + response.code(), SeverityLevel.Information);
                            if (response.isSuccessful()) {
                                transactionDataRepository.save(transaction);
                                telemetryClient.trackTrace("SAVED TRANSACTION OBJECT: " + transaction, SeverityLevel.Information);
                            }
                        }

                        @Override
                        public void onFailure(Call<Void> call, Throwable throwable) {
                            log.info("PAID FAILED ERROR {}", throwable.getMessage());
                            telemetryClient.trackTrace("PAID FAILED ERROR: " + throwable.getMessage(), SeverityLevel.Information);
                            transaction.setMessage(throwable.getMessage());
                            transactionDataRepository.save(transaction);
                        }
                    });
                }
            }

        });
    }

}
