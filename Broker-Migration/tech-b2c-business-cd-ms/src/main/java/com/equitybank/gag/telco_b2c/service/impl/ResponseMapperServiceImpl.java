package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.ChannelResponseDto;
import com.equitybank.gag.telco_b2c.enums.TransactionStatus;
import com.equitybank.gag.telco_b2c.service.ResponseMapperService;
import org.springframework.stereotype.Service;

@Service
public class ResponseMapperServiceImpl implements ResponseMapperService {

    @Override
    public ChannelResponseDto mapErrorMessage(String errorCode, String errorMessage) {
        ChannelResponseDto responseDto = new ChannelResponseDto();
        responseDto.setStatus(TransactionStatus.ERROR.toString());
        responseDto.setResponseCode(errorCode);
        responseDto.setResponseDesc(errorMessage);
        return responseDto;
    }
}
