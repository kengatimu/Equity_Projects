package com.equitybank.payments.imt.b2c.drcbroker.service;

public interface CallBackHTTPService {
    void sendCallback(String callBackUrl, String response, String type);
}
