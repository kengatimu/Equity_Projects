package com.equitybank.gag.orange_money_ms.service;


import com.equitybank.gag.orange_money_ms.dto.channel.response.ChannelResponseDto;

public interface ResponseMapperService {
    ChannelResponseDto mapErrorMessage(String errorCode, String errorMessage);
}
