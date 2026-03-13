package com.papss.middleware;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class PapssMiddlewareServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(PapssMiddlewareServiceApplication.class, args);
    }

}
