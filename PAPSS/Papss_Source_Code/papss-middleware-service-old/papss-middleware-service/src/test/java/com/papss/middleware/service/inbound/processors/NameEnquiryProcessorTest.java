package com.papss.middleware.service.inbound.processors;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.papss.middleware.config.CoreBankingProperties;
import com.papss.middleware.config.Path;
import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.dto.nameinquiry.NameInquiryDto;
import com.papss.middleware.dto.nameinquiry.response.NameInquiryResponseDto;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.exception.ApiException;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.inbound.domains.PartnerResponse;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.utils.ConstantUtils;
import com.papss.middleware.utils.HttpClient;
import com.papss.middleware.utils.RequestUtils;
import com.papss.middleware.utils.ResponseUtils;
import com.papss.middleware.utils.Utils;
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

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class NameEnquiryProcessorTest {

    @Mock
    private HttpClient httpClient;

    @Mock
    private CoreBankingProperties coreBankingProperties;

    @Mock
    private PapssSignature papssSignature;

    @Mock
    private ResponseUtils responseUtils;

    @Mock
    private PapssService papssService;

    @Mock
    private SystemConfig systemConfig;

    @Mock
    private ObjectMapper objectMapper;

    @InjectMocks
    private NameEnquiryProcessor processor;

    private RtpMessageDto messageDto;
    private Message message;
    private NameInquiryResponseDto nameInquiryResponse;

    @BeforeEach
    void setUp() throws Exception {
        // Setup core banking properties
        Path path = mock(Path.class);
        when(coreBankingProperties.getUrl()).thenReturn("http://core-banking");
        when(coreBankingProperties.getPath()).thenReturn(path);
        when(path.getNameInquiry()).thenReturn("/api/name-inquiry");

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

        // Setup name inquiry response
        nameInquiryResponse = new NameInquiryResponseDto();
        nameInquiryResponse.setStatus(Status.builder().type(ConstantUtils.ACCP).code("200").build());
        nameInquiryResponse.setAccountName("Test Account");
        nameInquiryResponse.setAccountNumber("1234567890");
    }

    @Test
    void testProcessMessage_SuccessfulNameInquiry() throws Exception {
        // Arrange
        String jsonResponse = "{\"status\":{\"type\":\"ACCP\",\"code\":\"200\"},\"accountName\":\"Test Account\",\"accountNumber\":\"1234567890\"}";
        ResponseEntity<String> responseEntity = new ResponseEntity<>(jsonResponse, HttpStatus.OK);

        // Mock static methods
        try (MockedStatic<Utils> mockedUtils = mockStatic(Utils.class);
             MockedStatic<RequestUtils> mockedRequestUtils = mockStatic(RequestUtils.class)) {

            // Mock Utils methods
            mockedUtils.when(() -> Utils.unmarshallMessageResponse(anyString())).thenReturn(message);
            XMLGregorianCalendar calendar = mock(XMLGregorianCalendar.class);
            mockedUtils.when(Utils::generateZuluDateTime).thenReturn(calendar);
            mockedUtils.when(() -> Utils.generateMessageId(anyString())).thenReturn("MSG123");

            // Mock RequestUtils methods
            NameInquiryDto nameInquiryDto = NameInquiryDto.builder()
                .transRef("TEST-REF")
                .tranDateTime("2023-01-01")
                .instId("TEST-INST")
                .build();
            mockedRequestUtils.when(() -> RequestUtils.mapInwardNameInquiryDto(any(Message.class))).thenReturn(nameInquiryDto);

            // Mock ObjectMapper
            when(objectMapper.writeValueAsString(any(NameInquiryDto.class))).thenReturn("{}");
            when(objectMapper.readValue(jsonResponse, NameInquiryResponseDto.class)).thenReturn(nameInquiryResponse);

            // Mock HTTP client
            when(httpClient.postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class)))
                    .thenReturn(responseEntity);

            // Mock response generation
            when(responseUtils.generateResponseMessage(anyString(), any(XMLGregorianCalendar.class), any(Message.class), 
                    any(NameInquiryResponseDto.class), anyString(), anyString(), anyBoolean()))
                    .thenReturn("<xml>response</xml>");

            // Mock signature generation
            when(papssSignature.generateSignature(anyString(), anyString(), anyString()))
                    .thenReturn("<signed>response</signed>");

            // Mock PAPSS service
            RtpMessageDto responseDto = RtpMessageDto.builder().sequence(2L).build();
            when(papssService.sendMessage(anyString(), anyString(), anyString())).thenReturn(responseDto);
            when(papssService.confirmReceivedMessage(anyLong(), anyString(), anyString())).thenReturn(true);

            // Act
            PartnerResponse response = processor.processMessage(messageDto);

            // Assert
            assertNotNull(response);
            assertEquals(200, response.getStatusCode());
            assertEquals(jsonResponse, response.getMessage());
            verify(papssService).sendMessage(eq("PAPSS123"), anyString(), eq("test-alias"));
            verify(papssService).confirmReceivedMessage(eq(2L), eq("PAPSS123"), eq("test-alias"));
        }
    }

    @Test
    void testProcessMessage_ErrorResponse() throws Exception {
        // Arrange
        ResponseEntity<String> responseEntity = new ResponseEntity<>("Error", HttpStatus.BAD_REQUEST);

        // Mock static methods
        try (MockedStatic<Utils> mockedUtils = mockStatic(Utils.class);
             MockedStatic<RequestUtils> mockedRequestUtils = mockStatic(RequestUtils.class)) {

            // Mock Utils methods
            mockedUtils.when(() -> Utils.unmarshallMessageResponse(anyString())).thenReturn(message);

            // Mock RequestUtils methods
            NameInquiryDto nameInquiryDto = NameInquiryDto.builder()
                .transRef("TEST-REF")
                .tranDateTime("2023-01-01")
                .instId("TEST-INST")
                .build();
            mockedRequestUtils.when(() -> RequestUtils.mapInwardNameInquiryDto(any(Message.class))).thenReturn(nameInquiryDto);

            // Mock ObjectMapper
            when(objectMapper.writeValueAsString(any(NameInquiryDto.class))).thenReturn("{}");

            // Mock HTTP client
            when(httpClient.postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class)))
                    .thenReturn(responseEntity);

            // Mock PAPSS service
            when(papssService.confirmReceivedMessage(anyLong(), anyString(), anyString())).thenReturn(true);

            // Act & Assert
            PartnerResponse response = processor.processMessage(messageDto);

            // Verify that confirmReceivedMessage was called
            verify(papssService).confirmReceivedMessage(eq(1L), eq("PAPSS123"), eq("test-alias"));

            // Verify response
            assertNotNull(response);
            assertEquals(400, response.getStatusCode());
            assertEquals("Error", response.getMessage());
        }
    }

   // @Test
    void testProcessMessage_ExceptionHandling() throws Exception {
        // Arrange
        // Mock static methods to throw exception
        try (MockedStatic<Utils> mockedUtils = mockStatic(Utils.class)) {
            // Mock Utils.unmarshallMessageResponse to throw a RuntimeException
            mockedUtils.when(() -> Utils.unmarshallMessageResponse(anyString())).thenThrow(new RuntimeException("Test exception"));

            // Act & Assert
            // The processor throws a RuntimeException
            RuntimeException exception = assertThrows(RuntimeException.class, () -> processor.processMessage(messageDto));

            // Verify the exception details
            assertEquals("Test exception", exception.getMessage());
        }
    }
}
