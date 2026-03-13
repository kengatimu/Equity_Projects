package com.papss.middleware.service.outbound.domains.credittransfer;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@JsonIgnoreProperties(ignoreUnknown = true)
public class Status {
    private String type;
    private String code;
    private String description;

    // Default constructor
    public Status() {
    }

    // Constructor with parameters
    @JsonCreator
    public Status(@JsonProperty("type") String type, @JsonProperty("code") String code, @JsonProperty("description") String description) {
        this.type = type;
        this.code = code;
        this.description = description;
    }
}
