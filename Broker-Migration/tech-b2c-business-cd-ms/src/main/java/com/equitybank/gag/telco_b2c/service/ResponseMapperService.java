package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.ChannelResponseDto;

public interface ResponseMapperService {
    ChannelResponseDto mapErrorMessage(String errorCode, String errorMessage);
}
