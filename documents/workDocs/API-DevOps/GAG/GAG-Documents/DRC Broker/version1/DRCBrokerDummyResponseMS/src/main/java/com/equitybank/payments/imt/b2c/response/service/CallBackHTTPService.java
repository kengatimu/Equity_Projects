package com.equitybank.payments.imt.b2c.response.service;

public interface CallBackHTTPService {
    void sendCallback(String callBackUrl, String response);
}
