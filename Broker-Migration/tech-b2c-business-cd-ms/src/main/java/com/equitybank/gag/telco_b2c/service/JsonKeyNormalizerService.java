package com.equitybank.gag.telco_b2c.service;

import com.google.gson.JsonElement;

public interface JsonKeyNormalizerService {
    JsonElement normalize(JsonElement element);
}
