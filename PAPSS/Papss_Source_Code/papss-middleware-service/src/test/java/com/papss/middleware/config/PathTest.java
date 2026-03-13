package com.papss.middleware.config;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class PathTest {

    @Test
    void gettersAndSetters_work() {
        Path p = new Path();
        p.setCreditTransfer("/ct");
        p.setNameInquiry("/ne");
        p.setTxConfirmation("/tx");
        p.setRecon("/recon");
        p.setRecallRequest("/rr");
        p.setPaymentReturn("/pr");

        assertEquals("/ct", p.getCreditTransfer());
        assertEquals("/ne", p.getNameInquiry());
        assertEquals("/tx", p.getTxConfirmation());
        assertEquals("/recon", p.getRecon());
        assertEquals("/rr", p.getRecallRequest());
        assertEquals("/pr", p.getPaymentReturn());
    }
}
