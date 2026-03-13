package com.papss.middleware.service;

import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.dto.txnconfirmation.TxConfirmationDto;
import com.papss.middleware.entities.PapssMessage;
import com.papss.middleware.entities.Transaction;
import com.papss.middleware.enums.Direction;
import com.papss.middleware.repositories.PapssMessageRepository;
import com.papss.middleware.repositories.TransactionRepository;
import com.papss.middleware.utils.TransactionParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class LoggerService {

    private final PapssMessageRepository papssMessageRepository;
    private final TransactionRepository transactionRepository;
    @Async
    public void logMessage(RtpMessageDto message, boolean isConfirmed, boolean isProcessed, String coreBankingResposne) {
        Optional<PapssMessage> papssMessageOptional = papssMessageRepository.findBySequenceNumber(message.getSequence());

        if (papssMessageOptional.isPresent()) {

            PapssMessage messageDto = papssMessageOptional.get();

            messageDto.setConfirmed(isConfirmed);
            messageDto.setProcessed(isProcessed);
            messageDto.setResponsePayload(coreBankingResposne);
            papssMessageRepository.save(messageDto);
        } else {

            PapssMessage papssMessage = new PapssMessage();
            papssMessage.setMessageType(message.getMessageType());
            papssMessage.setCountryCode(message.getCountryCode());
            papssMessage.setPapssId(message.getPapssId());
            papssMessage.setStatus(message.getStatusCode());

            papssMessage.setMessageType(message.getMessageType());
            papssMessage.setConfirmed(false);
            papssMessage.setCleared(message.getIsCleared());
            papssMessage.setParticipantBic(message.getBic());
            papssMessage.setRequestPayload(message.getContent());
            papssMessage.setResponsePayload("");
            papssMessage.setProcessed(false);
            papssMessage.setErrorCode(0); // TODO
            papssMessage.setSequenceNumber(message.getSequence());
            papssMessage.setSystemDate(OffsetDateTime.now());

            papssMessageRepository.save(papssMessage);
        }
    }
    @Async
    public void logTransaction(String pacs008XML, RtpMessageDto rtpMessageDto, Direction direction) {
        Transaction transaction = TransactionParser.parseXMLToTransaction(pacs008XML);
        transaction.setDirection(direction);
        Optional<Transaction> optionalTransaction = transactionRepository.findByEndToEndId(transaction.getEndToEndId());
        optionalTransaction.ifPresentOrElse(existingTransaction -> {
            existingTransaction.setStatus(rtpMessageDto.getErrorMapping());
            existingTransaction.setError(rtpMessageDto.getStatusCode());
            existingTransaction.setErrorDescription(rtpMessageDto.getDescription());
            transactionRepository.save(existingTransaction);
        }, () -> {
            transaction.setStatus(rtpMessageDto.getErrorMapping());
            transaction.setError(rtpMessageDto.getStatusCode());
            transaction.setErrorDescription(rtpMessageDto.getDescription());
            transactionRepository.save(transaction);
        });
    }
    @Async
    public void logTransaction(RtpMessageDto rtpMessageDto, TxConfirmationDto txConfirmationDto, Direction direction) {
        Optional<Transaction> optionalTransaction = transactionRepository.findByEndToEndId(txConfirmationDto.getTransRef());

        Transaction transaction = optionalTransaction.orElseGet(() -> {
            Transaction newTransaction = TransactionParser.parseXMLToTransaction(rtpMessageDto.getContent());
            newTransaction.setDirection(direction);
            return newTransaction;
        });

        transaction.setStatus(txConfirmationDto.getStatus().getType());
        transaction.setError(txConfirmationDto.getStatus().getCode());
        transaction.setErrorDescription(txConfirmationDto.getStatus().getDescription());

        transactionRepository.save(transaction);
    }

}
