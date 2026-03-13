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
import com.papss.middleware.service.inbound.domains.PartnerResponse;
import com.papss.middleware.service.outbound.domains.creditreturn.CreditReturnRequest;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.utils.*;
import montran.message.Message;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedStatic;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import javax.xml.datatype.XMLGregorianCalendar;

import static com.papss.middleware.utils.ConstantUtils.ACCP;
import static com.papss.middleware.utils.ConstantUtils.RJCT;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class PaymentReturnProcessorTest {

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

    @InjectMocks
    private PaymentReturnProcessor processor;

    private RtpMessageDto messageDto;
    private Message message;
    private CreditReturnRequest creditReturnRequest;
    private TxConfirmationDto txConfirmationDto;
    private ObjectMapper objectMapper;

    @BeforeEach
    void setUp() throws Exception {
        // Setup ObjectMapper
        objectMapper = new ObjectMapper();

        // Setup core banking properties
        Path path = mock(Path.class);
        lenient().when(coreBankingProperties.getUrl()).thenReturn("http://core-banking");
        lenient().when(coreBankingProperties.getPath()).thenReturn(path);
        lenient().when(path.getPaymentReturn()).thenReturn("/api/payment-return");

        // Setup message DTO
        messageDto = RtpMessageDto.builder()
                .content("<xml>test content</xml>")
                .papssId("PAPSS123")
                .sslKeyAlias("test-alias")
                .keyPass("test-pass")
                .sequence(1L)
                .bic("TESTBIC")
                .statusCode("200")
                .build();

        // Setup mock message
        message = mock(Message.class);

        // Setup credit return request
        creditReturnRequest = new CreditReturnRequest();
        creditReturnRequest.setEndToEndRef("TEST-REF");
        creditReturnRequest.setTranDateTime("2023-01-01");
        creditReturnRequest.setInstId("TEST-INST");
        creditReturnRequest.setInstBic("TEST-BIC");
        creditReturnRequest.setReturnReasonCode("DUPL");

        // Setup transaction confirmation response
        txConfirmationDto = new TxConfirmationDto();
        txConfirmationDto.setTransRef("TEST-REF");
        txConfirmationDto.setTranDateTime("2023-01-01");
        txConfirmationDto.setInstId("TEST-INST");
        txConfirmationDto.setStatus(Status.builder().type(ACCP).code("200").build());
    }

    @Test
    void testProcessMessage_SuccessfulPaymentReturn() throws Exception {
        // Arrange
        String jsonResponse = "{\"transRef\":\"TEST-REF\",\"tranDateTime\":\"2023-01-01\",\"instId\":\"TEST-INST\",\"status\":{\"type\":\"ACCP\",\"code\":\"200\"}}";
        ResponseEntity<String> responseEntity = new ResponseEntity<>(jsonResponse, HttpStatus.OK);

        // Mock static methods
        try (MockedStatic<Utils> mockedUtils = mockStatic(Utils.class);
             MockedStatic<CreditReturnMapper> mockedMapper = mockStatic(CreditReturnMapper.class)) {

            // Mock Utils methods
            mockedUtils.when(() -> Utils.unmarshallMessageResponse(anyString())).thenReturn(message);
            XMLGregorianCalendar calendar = mock(XMLGregorianCalendar.class);
            mockedUtils.when(Utils::generateZuluDateTime).thenReturn(calendar);
            mockedUtils.when(() -> Utils.generateMessageId(anyString())).thenReturn("MSG123");

            // Mock CreditReturnMapper
            mockedMapper.when(() -> CreditReturnMapper.mapXmlToCreditReturnRequest(any())).thenReturn(creditReturnRequest);

            // Mock HTTP client
            when(httpClient.postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class)))
                    .thenReturn(responseEntity);

            // We don't need to set objectMapper field as it's created locally in the method

            // Mock response generation
            when(responseUtils.generatePaymentResponseMessage004(any(Message.class), anyString(), anyBoolean(), 
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

            // Act
            PartnerResponse response = processor.processMessage(messageDto);

            // Assert
            assertNotNull(response);
            assertEquals(200, response.getStatusCode());
            verify(loggerService).logTransaction(eq(messageDto), any(TxConfirmationDto.class), eq(Direction.IN));
            verify(papssService).sendMessage(eq("PAPSS123"), anyString(), eq("test-alias"));
        }
    }

    @Test
    void testProcessMessage_ErrorResponse() throws Exception {
        // Arrange
        ResponseEntity<String> responseEntity = new ResponseEntity<>("Error", HttpStatus.BAD_REQUEST);

        // Mock static methods
        try (MockedStatic<Utils> mockedUtils = mockStatic(Utils.class);
             MockedStatic<CreditReturnMapper> mockedMapper = mockStatic(CreditReturnMapper.class)) {

            // Mock Utils methods
            mockedUtils.when(() -> Utils.unmarshallMessageResponse(anyString())).thenReturn(message);
            XMLGregorianCalendar calendar = mock(XMLGregorianCalendar.class);
            mockedUtils.when(Utils::generateZuluDateTime).thenReturn(calendar);
            mockedUtils.when(() -> Utils.generateMessageId(anyString())).thenReturn("MSG123");

            // Mock CreditReturnMapper
            mockedMapper.when(() -> CreditReturnMapper.mapXmlToCreditReturnRequest(any())).thenReturn(creditReturnRequest);

            // We don't need to set objectMapper field as it's created locally in the method

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
                    .statusCode("400")
                    .build();
            when(papssService.sendMessage(anyString(), anyString(), anyString())).thenReturn(pacs002Response);

            // Act
            PartnerResponse response = processor.processMessage(messageDto);

            // Assert
            assertNotNull(response);
            // The processor sets the status code to 200 even for error responses
            assertEquals(200, response.getStatusCode());
            verify(httpClient).postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class));
            verify(papssService).sendMessage(eq("PAPSS123"), anyString(), eq("test-alias"));
        }
    }

    @Test
    void testProcessMessage_ExceptionHandling() throws Exception {
        // Arrange
        // Mock Utils.unmarshallMessageResponse to throw an exception
        try (MockedStatic<Utils> mockedUtils = mockStatic(Utils.class)) {
            // This will cause an exception to be thrown at the beginning of the method
            mockedUtils.when(() -> Utils.unmarshallMessageResponse(anyString())).thenThrow(new RuntimeException("Test exception"));

            // Act & Assert
            // The exception should be thrown from the method since it's not caught
            assertThrows(RuntimeException.class, () -> processor.processMessage(messageDto));

            // Verify that no HTTP request was made (since an exception was thrown before that point)
            verify(httpClient, never()).postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class));
        }
    }
}
