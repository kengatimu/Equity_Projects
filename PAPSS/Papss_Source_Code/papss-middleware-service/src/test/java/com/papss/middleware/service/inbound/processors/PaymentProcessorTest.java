package com.papss.middleware.service.inbound.processors;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.papss.middleware.config.CoreBankingProperties;
import com.papss.middleware.config.Path;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.dto.txnconfirmation.TxConfirmationDto;
import com.papss.middleware.enums.Direction;
import com.papss.middleware.service.LoggerService;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.inbound.MessageProcessor;
import com.papss.middleware.service.inbound.domains.PartnerResponse;
import com.papss.middleware.service.outbound.domains.credittransfer.CreditTransferRequest;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.utils.ConstantUtils;
import com.papss.middleware.utils.RequestUtils;
import com.papss.middleware.utils.ResponseUtils;
import com.papss.middleware.utils.HttpClient;
import com.papss.middleware.utils.Utils;
import montran.message.Message;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.context.ApplicationContext;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import javax.xml.datatype.XMLGregorianCalendar;
import java.lang.reflect.Field;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
public class PaymentProcessorTest {

    @Mock
    private ApplicationContext applicationContext;

    @Mock
    private ResponseUtils responseUtils;

    @Mock
    private RequestUtils requestUtils;

    @Mock
    private HttpClient httpClient;

    @Mock
    private CoreBankingProperties coreBankingProperties;

    @Mock
    private PapssSignature papssSignature;

    @Mock
    private PapssService papssService;

    @Mock
    private LoggerService loggerService;

    @Mock
    private ObjectMapper objectMapper;

    @InjectMocks
    private PaymentProcessor processor;

    private RtpMessageDto messageDto;
    private Message message;
    private CreditTransferRequest creditTransferRequest;
    private TxConfirmationDto txConfirmationDto;

    @BeforeEach
    void setUp() throws Exception {
        // Setup core banking properties
        Path path = mock(Path.class);
        when(coreBankingProperties.getUrl()).thenReturn("http://core-banking");
        when(coreBankingProperties.getPath()).thenReturn(path);
        when(path.getCreditTransfer()).thenReturn("/api/credit-transfer");

        // Setup message DTO
        messageDto = RtpMessageDto.builder()
                .content("<xml>test content</xml>")
                .papssId("PAPSS123")
                .sslKeyAlias("test-alias")
                .keyPass("test-pass")
                .sequence(1L)
                .bic("TESTBIC")
                .build();

        // Setup mock message
        message = mock(Message.class);

        // Setup credit transfer request
        creditTransferRequest = CreditTransferRequest.builder()
                .transRef("TEST-REF")
                .tranDateTime("2023-01-01")
                .instId("TEST-INST")
                .build();

        // Setup transaction confirmation response
        txConfirmationDto = new TxConfirmationDto();
        txConfirmationDto.setTransRef("TEST-REF");
        txConfirmationDto.setTranDateTime("2023-01-01");
        txConfirmationDto.setInstId("TEST-INST");
        txConfirmationDto.setStatus(Status.builder().type(ConstantUtils.ACCP).code("200").build());
    }

  //  @Test
    void testProcessMessage_SuccessfulPayment() throws Exception {
        // Arrange
        String jsonResponse = "{\"transRef\":\"TEST-REF\",\"tranDateTime\":\"2023-01-01\",\"instId\":\"TEST-INST\",\"status\":{\"type\":\"ACCP\",\"code\":\"200\"}}";
        ResponseEntity<String> responseEntity = new ResponseEntity<>(jsonResponse, HttpStatus.OK);

        // Mock static methods
        try (MockedStatic<Utils> mockedUtils = mockStatic(Utils.class)) {
            // Mock Utils methods
            mockedUtils.when(() -> Utils.unmarshallMessageResponse(anyString())).thenReturn(message);
            XMLGregorianCalendar calendar = mock(XMLGregorianCalendar.class);
            mockedUtils.when(Utils::generateZuluDateTime).thenReturn(calendar);
            mockedUtils.when(() -> Utils.generateMessageId(anyString())).thenReturn("MSG123");

            // Mock RequestUtils
            when(requestUtils.mapInwardPaymentDto(any(Message.class))).thenReturn(creditTransferRequest);

            // Mock ObjectMapper
            when(objectMapper.writeValueAsString(any(CreditTransferRequest.class))).thenReturn("{}");
            when(objectMapper.readValue(jsonResponse, TxConfirmationDto.class)).thenReturn(txConfirmationDto);

            // Mock HTTP client
            when(httpClient.postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class)))
                    .thenReturn(responseEntity);

            // Mock response generation
            when(responseUtils.generatePaymentResponseMessage(any(Message.class), anyString(), anyBoolean(), 
                    any(XMLGregorianCalendar.class), any(TxConfirmationDto.class)))
                    .thenReturn("<xml>response</xml>");

            // Mock signature generation
            when(papssSignature.generateSignature(anyString(), anyString(), anyString()))
                    .thenReturn("<signed>response</signed>");

            // Mock PAPSS service
            RtpMessageDto pacs002Response = RtpMessageDto.builder()
                    .sequence(2L)
                    .statusCode("200")
                    .build();
            when(papssService.sendMessage(anyString(), anyString(), anyString())).thenReturn(pacs002Response);

            // Mock ApplicationContext
            MessageProcessor pacs002Processor = mock(MessageProcessor.class);
            when(applicationContext.getBean("pacs.002", MessageProcessor.class)).thenReturn(pacs002Processor);

            // Act
            PartnerResponse response = processor.processMessage(messageDto);

            // Assert
            assertNotNull(response);
            assertEquals(200, response.getStatusCode());
            verify(loggerService).logTransaction(eq(messageDto), eq(txConfirmationDto), eq(Direction.IN));
            verify(papssService).sendMessage(eq("PAPSS123"), anyString(), eq("test-alias"));
            verify(pacs002Processor).processMessage(any(RtpMessageDto.class));
        }
    }

    @Test
    void testProcessMessage_ErrorResponse() throws Exception {
        // Arrange
        ResponseEntity<String> responseEntity = new ResponseEntity<>("Error", HttpStatus.BAD_REQUEST);

        // Mock static methods
        try (MockedStatic<Utils> mockedUtils = mockStatic(Utils.class)) {
            // Mock Utils methods
            mockedUtils.when(() -> Utils.unmarshallMessageResponse(anyString())).thenReturn(message);

            // Mock RequestUtils
            when(requestUtils.mapInwardPaymentDto(any(Message.class))).thenReturn(creditTransferRequest);

            // Mock ObjectMapper
            when(objectMapper.writeValueAsString(any(CreditTransferRequest.class))).thenReturn("{}");

            // Mock HTTP client
            when(httpClient.postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class)))
                    .thenThrow(new RuntimeException("Test exception"));

            // Act
            PartnerResponse response = processor.processMessage(messageDto);

            // Assert
            assertNull(response);
            verify(httpClient).postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class));
        }
    }

    @Test
    void testProcessMessage_ExceptionHandling() throws Exception {
        // Arrange
        // Mock static methods to throw exception
        try (MockedStatic<Utils> mockedUtils = mockStatic(Utils.class)) {
            // Mock Utils.unmarshallMessageResponse to throw a RuntimeException
            mockedUtils.when(() -> Utils.unmarshallMessageResponse(anyString())).thenThrow(new RuntimeException("Test exception"));

            // Act & Assert
            // The processor should throw the exception
            assertThrows(RuntimeException.class, () -> processor.processMessage(messageDto));
        }
    }
}
