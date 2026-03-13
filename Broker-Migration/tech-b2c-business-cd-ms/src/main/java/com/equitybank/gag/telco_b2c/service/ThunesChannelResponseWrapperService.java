package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.thunes.response.ChannelResponse;

public interface ThunesChannelResponseWrapperService {
    ChannelResponse wrapImtResponse(String imtResponseString);

}
