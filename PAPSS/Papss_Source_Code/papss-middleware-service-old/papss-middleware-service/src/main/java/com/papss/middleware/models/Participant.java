package com.papss.middleware.models;

import lombok.Data;

@Data
public class Participant {
    private String instBic;
    private String instId;
    private String country;
    private String sslKeyAlias;
    private String keyStorePath;
    private String keyPass;
    private String keyStoreType;
    private String provider;
    private String apiKey;
    private String salt;
}
