/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.vodacom;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 *
 * @author ronaldcheruiyot
 */
    
@Data
@AllArgsConstructor
public class VodacomDTO {
    
    private int statusCode;
    private String tranId;
    private String telcoStatusCode;
    private String telcoStatusMessage;

}
