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
import com.microsoft.applicationinsights.telemetry.ExceptionTelemetry;
import com.microsoft.applicationinsights.telemetry.SeverityLevel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
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

//    private final TaskExecutor exec = new SimpleAsyncTaskExecutor();
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

    @Autowired
    TaskExecutor taskExecutor;

    @Autowired
    Gson gson;

    @KafkaListener(id = "transactionGroup", topics = "transactionEnd")
    public void listen(@Payload Map<String, String> response) {
        log.info("Response From Consumer: ".toUpperCase() + response);
        telemetryClient.trackTrace("Response From Consumer: ".toUpperCase() + response, SeverityLevel.Information);

//        this.exec.execute(() -> {
        taskExecutor.execute(() -> {
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
                    log.info(wrid + ": Call Back To Set Transaction As PAID Request: " + gson.toJson(transaction));
                    telemetryClient.trackTrace(wrid + ": Call Back To Set Transaction As PAID Request: " + gson.toJson(transaction), SeverityLevel.Information);
                    //send setPaid to wr
                    wrService().setTransactionPaid(transaction.getWrid(), transaction.getReference()).enqueue(new Callback<Void>() {
                        @Override
                        public void onResponse(Call<Void> call, Response<Void> response) {
                            log.info(wrid + ": Call Back To Set Transaction As PAID, Was Successful: " + response.code());
                            telemetryClient.trackTrace(wrid + ": Call Back To Set Transaction As PAID, Was Successful: " + response.code(), SeverityLevel.Information);
                            transaction.setCallBackStatus("CALL BACK SUCCESS");
                            transaction.setCallBackResponse("Call Back To Set Transaction As PAID, Was Successful For Transaction: " + wrid + ". Status: " + response.code());
                            transactionDataRepository.save(transaction);
                        }

                        @Override
                        public void onFailure(Call<Void> call, Throwable throwable) {
                            log.info(wrid + ": Call Back To Set Transaction As PAID, Failed. Exception Occurred: " + throwable.getMessage());
                            telemetryClient.trackTrace(wrid + ": Call Back To Set Transaction As PAID, Failed. Exception Occurred: " + throwable.getMessage(), SeverityLevel.Critical);
                            transaction.setCallBackStatus("CALL BACK FAILED");
                            transaction.setCallBackResponse("Call Back To Set Transaction As PAID, Failed For Transaction: " + wrid + ". Error: " + throwable.getMessage());
                            transactionDataRepository.save(transaction);

                            ExceptionTelemetry et = new ExceptionTelemetry(throwable);
                            telemetryClient.trackException(et);
                        }
                    });

                } else if (response.get("responsecode").equalsIgnoreCase("0036")) {
                    //first set/unlock 

//                    TransactionChangeStatus transactionChangeStatus = new TransactionChangeStatus();
//                    transactionChangeStatus.setResponseCode("0036");
//                    transactionChangeStatus.setResponseMessage("Success");
//                    transactionChangeStatus.setTxnReference(transaction.getWrid());
//                    PropertiesMap map = new PropertiesMap();
//
//                    transactionChangeStatus.setResponseCode("0036");
//                    map.addProperty("responsecode", "0036");
//                    map.addProperty("responsemessage", "Transaction Acknowledged");
//                    map.addProperty("mycustom1", "Transaction with Reference ID [" + reference + "] is being processed ");
//                    transactionChangeStatus.setProperties(map);
                    log.info(wrid + ": Call Back To Set Transaction, With Status Code 0036, As UNLOCKED Started");
                    telemetryClient.trackTrace(wrid + ": Call Back To Set Transaction, With Status Code 0036, As UNLOCKED Started", SeverityLevel.Information);

//                    wrService().setTransactionAcknowledged(transaction.getWrid(), transaction.getWrid(), transactionChangeStatus).enqueue(new Callback<Void>() {
                    wrService().setTransactionUnlocked(transaction.getWrid(), transaction.getWrid()).enqueue(new Callback<Void>() {
                        @Override
                        public void onResponse(Call<Void> call, Response<Void> response) {
                            transaction.setMessage("UNLOCKING COMPLETE [ message = " + response.body() + "]");
                            transaction.setStatus("UNLOCKED" + response.code());
                            transaction.setCallBackStatus("CALL BACK SUCCESS");
                            transaction.setCallBackResponse("Call Back To Set Transaction, With Status Code 0036, As UNLOCKED Was Successful For Transaction: " + wrid + ". Status: " + response.code());

                            log.info(wrid + ": Call Back To Set Transaction, With Status Code 0036, As UNLOCKED Was Successful: " + response.code());
                            telemetryClient.trackTrace(wrid + ": Call Back To Set Transaction, With Status Code 0036, As UNLOCKED Was Successful: ".toUpperCase() + response.code(), SeverityLevel.Information);
                            transactionDataRepository.save(transaction);
                        }

                        @Override
                        public void onFailure(Call<Void> call, Throwable throwable) {
                            transaction.setStatus("UNLOCKED " + throwable.getMessage());
                            transaction.setMessage("UNLOCKING FAILED");
                            transaction.setCallBackStatus("CALL BACK FAILED");
                            transaction.setCallBackResponse("Call Back To Set Transaction, With Status Code 0036, As UNLOCKED Failed For Transaction: " + wrid + ". Status: " + throwable.getMessage());

                            log.error(wrid + ": Call Back To Set Transaction, With Status Code 0036, As UNLOCKED Failed. Exception Occurred: " + throwable.getMessage());
                            telemetryClient.trackTrace(wrid + ": Call Back To Set Transaction, With Status Code 0036, As UNLOCKED Failed. Exception Occurred: " + throwable.getMessage(), SeverityLevel.Error);

                            ExceptionTelemetry et = new ExceptionTelemetry(throwable);
                            telemetryClient.trackException(et);
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
                    log.info(wrid + ": Call Back To Set Transaction As FAILED Request: " + gson.toJson(transactionChangeStatus));
                    telemetryClient.trackTrace(wrid + ": Call Back To Set Transaction As FAILED Request: " + gson.toJson(transactionChangeStatus), SeverityLevel.Information);

                    wrService().setTransactionFailed(transaction.getWrid(), transaction.getReference(), transactionChangeStatus).enqueue(new Callback<Void>() {
                        @Override
                        public void onResponse(Call<Void> call, Response<Void> response) {
                            if (response.isSuccessful()) {
                                transaction.setCallBackStatus("CALL BACK SUCCESS");
                                transaction.setCallBackResponse("Call Back To Set Transaction As FAILED, Was Successful For Transaction: " + wrid + ". Status: " + response.code());

                                log.info(wrid + " CallBack To Set Transaction As FAILED, Was Successful " + response.code());
                                telemetryClient.trackTrace(wrid + " Call Back To Set Transaction As FAILED, Was Successful " + response.code(), SeverityLevel.Information);
                                transactionDataRepository.save(transaction);
                                telemetryClient.trackTrace(wrid + " SAVED TRANSACTION OBJECT: " + transaction, SeverityLevel.Information);
                            }
                        }

                        @Override
                        public void onFailure(Call<Void> call, Throwable throwable) {
                            transaction.setMessage(throwable.getMessage());
                            transaction.setCallBackStatus("CALL BACK FAILED");
                            transaction.setCallBackResponse("Call Back To Set Transaction As FAILED, Failed For Transaction: " + wrid + ". Status: " + throwable.getMessage());

                            log.info(wrid + " Call Back To Set Transaction As FAILED, Failed. Exception Occurred: " + throwable.getMessage());
                            telemetryClient.trackTrace(wrid + " Call Back To Set Transaction As FAILED, Failed Exception Occurred: " + throwable.getMessage(), SeverityLevel.Critical);
                            transactionDataRepository.save(transaction);

                            ExceptionTelemetry et = new ExceptionTelemetry(throwable);
                            telemetryClient.trackException(et);
                        }
                    });
                }
            } else {
                log.error(wrid + ": Transaction Does Not Exist In Transactions Table");
                telemetryClient.trackTrace(wrid + ": Transaction Does Not Exist In Transactions Table", SeverityLevel.Error);
            }
        });
    }

}
