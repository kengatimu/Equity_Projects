package com.papss.middleware.service.inbound;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.entities.PapssMessage;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.inbound.domains.PartnerResponse;
import com.papss.middleware.repositories.PapssMessageRepository;
import com.papss.middleware.repositories.TransactionRepository;
import com.papss.middleware.service.KeyStoreService;
import com.papss.middleware.service.LoggerService;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.utils.ConstantUtils;
import com.papss.middleware.utils.HttpClient;
import com.papss.middleware.utils.TransactionParser;
import com.papss.middleware.utils.Utils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

@Slf4j
@Service
@RequiredArgsConstructor
public class ParticipantProcessorService {

    private final ParticipantsConfig participantsConfig;
    private final SystemConfig systemConfig;
    private final HttpClient httpClient;
    private final KeyStoreService keyStoreService;
    private final ApplicationContext applicationContext;
    private final LoggerService loggerService;
    private final PapssService papssService;
    private final PapssMessageRepository papssMessageRepository;
    private final TransactionRepository transactionRepository;

    /**
     * Process all participants in parallel using virtual threads.
     * This implementation is more efficient than the previous one because:
     * 1. It uses virtual threads which are lightweight and can handle many concurrent tasks
     * 2. It doesn't create a new thread pool for each execution
     * 3. It properly handles exceptions and ensures all tasks complete
     */
    public void processParticipant() {
        List<Participant> participants = participantsConfig.getParticipants();

        // Create a virtual thread executor for processing participants
        try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) {
            // Submit each participant for processing
            List<Future<Object>> futures = participants.parallelStream()
                    .map(participant -> executor.submit(() -> {
                        try {
                            executeMessage(participant);
                        } catch (Exception e) {
                            log.error("Error processing participant {}: {}", participant.getInstId(), e.getMessage(), e);
                        }
                        return null;
                    }))
                    .toList();

            futures.forEach(future -> {
                try {
                    future.get();
                } catch (InterruptedException | ExecutionException e) {
                    log.error("Error waiting for participant processing to complete", e);
                    Thread.currentThread().interrupt(); // Preserve interrupt status
                }
            });

//            // Submit each participant for processing
//            for (Participant participant : participants) {
//                futures.add(executor.submit(() -> {
//                    try {
//                        executeMessage(participant);
//                    } catch (Exception e) {
//                        log.error("Error processing participant {}: {}", participant.getInstId(), e.getMessage(), e);
//                    }
//                    return null;
//                }));
//            }
//
//            // Wait for all tasks to complete
//            for (Future<?> future : futures) {
//                try {
//                    future.get();
//                } catch (InterruptedException | ExecutionException e) {
//                    log.error("Error waiting for participant processing to complete", e);
//                    Thread.currentThread().interrupt(); // Preserve interrupt status
//                }
//            }
        } // ExecutorService is automatically closed here due to try-with-resources
    }
            
    private void executeMessage(Participant participant) throws IOException {
        String papssId = participant.getInstId();
        String sslKeyAlias = participant.getSslKeyAlias();
        String papssUrl = buildPapssUrl();
        
        // Get the number of concurrent threads from configuration
        int concurrentThreads = systemConfig.getPollingExecutorsPerParticipant();

        // Create a thread pool for concurrent requests
        try (ExecutorService executor = Executors.newVirtualThreadPerTaskExecutor()) {
            List<Future<?>> futures = new ArrayList<>();
            
            // Submit multiple concurrent requests
            for (int i = 0; i < concurrentThreads; i++) {
                final int threadIndex = i;
                futures.add(executor.submit(() -> {
                    try {
                        log.debug("Thread {} for participant {} starting request", threadIndex, papssId);
                        HttpHeaders headers = createHeaders(papssId);
                        // Add a thread identifier to help with debugging
                        headers.add("X-Thread-ID", String.valueOf(threadIndex));
                        HttpEntity<String> request = new HttpEntity<>(headers);
                        
                        // Use the HttpClient which uses the persistent connection
                        ResponseEntity<String> responseFromIps = httpClient.getClient(papssUrl, request, sslKeyAlias, String.class);
                        processResponse(responseFromIps, participant);
                        log.debug("Thread {} for participant {} completed request", threadIndex, papssId);
                    } catch (Exception e) {
                        log.error("Thread {} error while processing participant {}: {}", 
                                  threadIndex, papssId, e.getMessage(), e);
                    }
                    return null;
                }));
            }
            
            // Wait for all requests to complete
            for (Future<?> future : futures) {
                try {
                    future.get();
                } catch (InterruptedException | ExecutionException e) {
                    log.error("Error waiting for concurrent requests to complete for participant {}: {}", 
                              papssId, e.getMessage(), e);
                    Thread.currentThread().interrupt(); // Preserve interrupt status
                }
            }
        }
    }

    private String buildPapssUrl() {
        return "https://" + systemConfig.getIpsBaseUrl() + ":" + systemConfig.getIpsPort() + "/papss/Message";
    }

    private HttpHeaders createHeaders(String papssId) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);
        headers.add("X-PAPSSRTP-Channel", papssId);
        headers.add("X-PAPSS-RTP-Version", "1");
        return headers;
    }

    private void processResponse(ResponseEntity<String> response, Participant participant) throws IOException {
        List<String> reqStsHeaders = response.getHeaders().get("X-PAPSSRTP-ReqSts");
        if (reqStsHeaders != null && !reqStsHeaders.isEmpty() && "EMPTY".equals(reqStsHeaders.get(0))) {
            //log.debug("Empty Response from IPS.");
            return;
        }

        log.info("Getting Request from IPS");
        String messageType = Utils.getHeader(response.getHeaders(), ConstantUtils.X_PAPSSRTP_MessageType);
        String message = response.getBody();
        log.debug("Message Type: {}", messageType);
        log.debug("Message: {}", message);

        long sequence = Long.parseLong(response.getHeaders().get("X-PAPSSRTP-MessageSeq").get(0));
        boolean possibleDuplicate = isPossibleDuplicate(response);
        int remainingOutputs = getRemainingOutputs(response);

        RtpMessageDto messageDto = buildMessageDto(participant, messageType, message, sequence, possibleDuplicate, remainingOutputs);
        loggerService.logMessage(messageDto, false, false, "");

        processMessage(messageDto, messageType, sequence, participant.getSslKeyAlias());
    }

    private boolean isPossibleDuplicate(ResponseEntity<String> response) {
        return response.getHeaders().get("X-PAPSSRTP-PossibleDuplicate") != null;
    }

    private int getRemainingOutputs(ResponseEntity<String> response) {
        List<String> remainingOutputsHeaders = response.getHeaders().get("X-PAPSSRTP-RemainingOutputs");
        return remainingOutputsHeaders != null ? Integer.parseInt(remainingOutputsHeaders.get(0)) : 0;
    }

    private RtpMessageDto buildMessageDto(Participant participant, String messageType, String message, long sequence, boolean possibleDuplicate, int remainingOutputs) {
        return RtpMessageDto.builder()
                .messageType(messageType)
                .sequence(sequence)
                .isCleared(false)
                .remainingOutputs(remainingOutputs)
                .bic(participant.getInstBic())
                .countryCode(participant.getCountry())
                .papssId(participant.getInstId())
                .sslKeyAlias(participant.getSslKeyAlias())
                .keyPass(participant.getKeyPass())
                .content(message)
                .possibleDuplicate(possibleDuplicate)
                .build();
    }

    private void processMessage(RtpMessageDto messageDto, String messageType, long sequence, String sslKeyAlias) {
        log.debug("Processing Message: {}", messageType);
        MessageProcessor messageProcessor = applicationContext.getBean(messageType, MessageProcessor.class);
        PartnerResponse partnerResponse = messageProcessor.processMessage(messageDto);
        boolean isConfirmed = false;
        boolean isProcessed = partnerResponse.getStatusCode() == 200 || partnerResponse.getStatusCode() == 0;

        if (!messageType.equals("acmt.023")) {
            isConfirmed = papssService.confirmReceivedMessage(sequence, messageDto.getPapssId(), sslKeyAlias);
        }
        String message = partnerResponse != null ? partnerResponse.getMessage() : "";
        loggerService.logMessage(messageDto, isConfirmed, isProcessed, message);
    }
}
