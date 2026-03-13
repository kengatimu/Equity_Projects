package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.service.JsonKeyNormalizerService;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class JsonKeyNormalizerServiceImpl implements JsonKeyNormalizerService {
    @Override
    public JsonElement normalize(JsonElement element) {
        if (element.isJsonObject()) {
            JsonObject original = element.getAsJsonObject();
            JsonObject result = new JsonObject();

            for (Map.Entry<String, JsonElement> entry : original.entrySet()) {
                String newKey = toCamelCase(entry.getKey());
                result.add(newKey, normalize(entry.getValue())); // handle nested objects
            }
            return result;
        }

        if (element.isJsonArray()) {
            JsonArray array = new JsonArray();
            for (JsonElement item : element.getAsJsonArray()) {
                array.add(normalize(item)); // normalize each array item
            }
            return array;
        }
        return element; // primitive (string, number, etc.)
    }

    // Converts snake_case or kebab-case to camelCase
    private String toCamelCase(String text) {
        String[] parts = text.split("[_\\-]");
        StringBuilder sb = new StringBuilder(parts[0]);

        for (int i = 1; i < parts.length; i++) {
            if (parts[i].length() > 0) {
                sb.append(Character.toUpperCase(parts[i].charAt(0)))
                        .append(parts[i].substring(1));
            }
        }
        return sb.toString();
    }
}
