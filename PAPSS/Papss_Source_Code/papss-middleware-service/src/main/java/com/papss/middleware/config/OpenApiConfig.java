package com.papss.middleware.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.tags.Tag;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Arrays;
import java.util.List;

@Configuration
public class OpenApiConfig {
    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("PAPSS Middleware API")
                        .version("1.0")
                        .description("API documentation for PAPSS Middleware Service, including both inbound and outbound APIs")
                        .license(new License().name("Apache 2.0").url("http://springdoc.org")))
                .tags(createTags());
    }

    private List<Tag> createTags() {
        return Arrays.asList(
                new Tag().name("Credit Transfer").description("Credit transfer operations"),
                new Tag().name("Name Enquiry").description("Name enquiry operations"),
                new Tag().name("FX Rate").description("Foreign exchange rate operations"),
                new Tag().name("Positions").description("Position management operations"),
                new Tag().name("Participant Info").description("Participant information operations")
        );
    }
}
