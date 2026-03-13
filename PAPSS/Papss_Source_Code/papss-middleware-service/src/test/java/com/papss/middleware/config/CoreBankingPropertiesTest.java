package com.papss.middleware.config;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CoreBankingPropertiesTest {

    @Test
    void gettersAndSetters_work() {
        CoreBankingProperties props = new CoreBankingProperties();
        Path path = new Path();
        path.setCreditTransfer("/ct");

        props.setUrl("http://cb");
        props.setPath(path);

        assertEquals("http://cb", props.getUrl());
        assertNotNull(props.getPath());
        assertEquals("/ct", props.getPath().getCreditTransfer());
    }
}
