package com.papss.middleware.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
@NoArgsConstructor
public class ResponseDto {
    private boolean status;
    private String message;
    private Object data;

    public ResponseDto(boolean status, String message) {
        this.status = status;
        this.message = message;
    }
    public ResponseDto(boolean status, String message, Object data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }
    public ResponseDto(boolean status, Object data) {
        this.status = status;
        this.data = data;
    }
}
