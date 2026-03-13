package com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "idType",
        "idNumber",
        "idCountryCode",
        "idDeliveryDate"
})
public class Identification implements Serializable {

    private static final long serialVersionUID = 8737810998511367895L;

    @Size(max = 50, message = "identification.idType must not exceed 50 characters")
    @JsonProperty("idType")
    private String idType;

    @Size(max = 100, message = "identification.idNumber must not exceed 100 characters")
    @JsonProperty("idNumber")
    private String idNumber;

    @Pattern(regexp = "[A-Z]{3}", message = "identification.idCountryCode must be ISO-3166 alpha-3")
    @JsonProperty("idCountryCode")
    private String idCountryCode;

    @Pattern(regexp = "\\d{4}-\\d{2}-\\d{2}", message = "identification.idDeliveryDate must be in yyyy-MM-dd format")
    @JsonProperty("idDeliveryDate")
    private String idDeliveryDate;


    @JsonProperty("idType")
    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    @JsonProperty("idNumber")
    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    @JsonProperty("idCountryCode")
    public String getIdCountryCode() {
        return idCountryCode;
    }

    public void setIdCountryCode(String idCountryCode) {
        this.idCountryCode = idCountryCode;
    }

    @JsonProperty("idDeliveryDate")
    public String getIdDeliveryDate() {
        return idDeliveryDate;
    }

    public void setIdDeliveryDate(String idDeliveryDate) {
        this.idDeliveryDate = idDeliveryDate;
    }
}
