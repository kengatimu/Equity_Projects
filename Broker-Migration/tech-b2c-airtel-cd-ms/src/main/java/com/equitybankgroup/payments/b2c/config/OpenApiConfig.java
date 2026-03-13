/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.Contact;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Bank Insights API")
                        .version("1.0")
                        .description("BankInsight is an innovative web application designed to provide bank customers with a comprehensive and intuitive platform for inquiring, searching, and viewing their bank transactions. The application aims to enhance financial transparency and empower users with detailed insights into their banking activities, promoting better financial management and decision-making.")
                        .contact(new Contact()
                                .name("Bank Insights")
                                .url("URL")
                                .email("info@equitybankgroup.co.ke")));
    }
}

