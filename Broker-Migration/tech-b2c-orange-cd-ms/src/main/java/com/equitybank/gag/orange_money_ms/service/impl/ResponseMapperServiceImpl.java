package com.equitybank.gag.orange_money_ms.service.impl;

import com.equitybank.gag.orange_money_ms.dto.channel.response.ChannelResponseDto;
import com.equitybank.gag.orange_money_ms.service.ResponseMapperService;
import org.springframework.stereotype.Service;

import static com.equitybank.gag.orange_money_ms.enums.TransactionStatus.ERROR;

@Service
public class ResponseMapperServiceImpl implements ResponseMapperService {

    @Override
    public ChannelResponseDto mapErrorMessage(String errorCode, String errorMessage) {
        ChannelResponseDto responseDto = new ChannelResponseDto();
        responseDto.setStatus(ERROR.toString());
        responseDto.setResponseCode(errorCode);
        responseDto.setResponseDesc(errorMessage);
        return responseDto;
    }
}
