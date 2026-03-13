package com.papss.middleware.service.outbound;

import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.dto.fxrate.PostFxRateDto;
import com.papss.middleware.dto.fxrate.response.PostFxRateResponse;
import com.papss.middleware.enums.ErrorCodes;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.utils.HttpClient;
import com.papss.middleware.utils.MessageTypeConstants;
import com.papss.middleware.utils.MustacheTemplateEngine;
import com.papss.middleware.utils.Utils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.HttpClientErrorException;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

public class FxRateServiceTest {

    private SystemConfig systemConfig;
    private HttpClient httpClient;
    private PapssSignature papssSignature;
    private MustacheTemplateEngine templateEngine;

    private FxRateService service;

    @BeforeEach
    void setUp() {
        systemConfig = mock(SystemConfig.class);
        httpClient = mock(HttpClient.class);
        papssSignature = mock(PapssSignature.class);
        templateEngine = mock(MustacheTemplateEngine.class);
        service = new FxRateService(systemConfig, httpClient, papssSignature, templateEngine);
        when(systemConfig.getIpsBaseUrl()).thenReturn("ips.example");
        when(systemConfig.getIpsPort()).thenReturn("8443");
        when(systemConfig.getToClearingSystemId()).thenReturn("TOCS");
    }

    private PostFxRateDto buildDto() {
        PostFxRateDto dto = new PostFxRateDto();
        dto.setInstId("P01");
        dto.setAccountType("ACC");
        dto.setBuyRate(new BigDecimal("1.2"));
        dto.setCountryCode("GH");
        dto.setLocalCurrency("GHS");
        dto.setFxRateName("USDGHS");
        dto.setSellRate(new BigDecimal("1.3"));
        return dto;
    }

    @Test
    void updateFxRate_successACCP() throws Exception {
        when(templateEngine.render(eq(MessageTypeConstants.POST_FX_RATE_XML), anyMap())).thenReturn("<fx/>");
        when(papssSignature.generateSignature(anyString(), anyString(), anyString())).thenReturn("<signed/>");

        HttpHeaders headers = new HttpHeaders();
        headers.add("X-PAPSSRTP-ReqSts", "ACCP");
        when(httpClient.postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class)))
                .thenReturn(ResponseEntity.ok().headers(headers).body("OK"));

        PostFxRateResponse resp = service.updateFxRate(buildDto(), "P01", "alias", "secret");
        assertNotNull(resp);
        assertEquals("USDGHS", resp.getFxRateName());
        assertNotNull(resp.getTranRef());
        assertNotNull(resp.getTranDateTime());
        Status sts = resp.getStatus();
        assertEquals(ErrorCodes.UNKNOWN.getMapping(), sts.getType());
        assertEquals(ErrorCodes.UNKNOWN.getValue(), sts.getCode());
        assertEquals(ErrorCodes.UNKNOWN.getDescription(), sts.getDescription());
    }

    @Test
    void updateFxRate_handles400BadRequest() throws Exception {
        when(templateEngine.render(eq(MessageTypeConstants.POST_FX_RATE_XML), anyMap())).thenReturn("<fx/>");
        when(papssSignature.generateSignature(anyString(), anyString(), anyString())).thenReturn("<signed/>");

        String body = "Some error ABCD"; // last four used as code
        when(httpClient.postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class)))
                .thenThrow(new HttpClientErrorException(HttpStatus.BAD_REQUEST, "Bad", body.getBytes(), null));

        PostFxRateResponse resp = service.updateFxRate(buildDto(), "P01", "alias", "secret");
        assertNotNull(resp);
        assertEquals("RJCT", resp.getStatus().getType());
        assertEquals("ABCD", resp.getStatus().getCode());
        assertNotNull(resp.getStatus().getDescription());
    }
}
