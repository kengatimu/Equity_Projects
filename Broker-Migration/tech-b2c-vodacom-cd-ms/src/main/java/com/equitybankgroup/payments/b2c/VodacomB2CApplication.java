package com.equitybankgroup.payments.b2c;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ApplicationContext;


@SpringBootApplication
public class VodacomB2CApplication {
    
    public static ApplicationContext applicationContext;

	public static void main(String[] args) {
		SpringApplication app = new SpringApplication(VodacomB2CApplication.class);
                applicationContext = app.run(args);
	}
        
}
