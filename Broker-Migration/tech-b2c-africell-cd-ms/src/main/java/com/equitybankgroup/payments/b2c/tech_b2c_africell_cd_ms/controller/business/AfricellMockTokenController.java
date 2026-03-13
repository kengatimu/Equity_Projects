/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.controller.business;

import java.util.UUID;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author ronaldcheruiyot
 */
@RestController
@RequestMapping("/")
public class AfricellMockTokenController {
    
    @PostMapping("token")
    public ResponseEntity<?> transaction()
    {
        return new ResponseEntity(getSuccessLoginResponse(), HttpStatus.OK);
    }
    
    public String getSuccessLoginResponse()
    {
        return "{\n" +
"    \"access_token\": \" " + UUID.randomUUID().toString() + "\",\n" +
"    \"scope\": \"am_application_scope default\",\n" +
"    \"token_type\": \"Bearer\",\n" +
"    \"expires_in\": 3586\n" +
"}";
    }
    
}
