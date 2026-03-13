/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.api;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 *
 * @author ronaldcheruiyot
 */
@Data
public class ErrorResponse {
    private String errorCode;
    private String message;
    private List<String> details;

    public ErrorResponse( String errorCode, String message, List<String> details) {
        super();
        this.errorCode = errorCode;
        this.message = message;
        this.details = details;
    }

}

