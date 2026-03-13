/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.airtel.allocation.common;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *
 * @author ronaldcheruiyot
 */
public class Data {
    @JsonProperty("first_name")
    private String firstName;
    
    @JsonProperty("grade")
    private String grade;
    
    @JsonProperty("is_barred")
    private String isBarred;
    
    @JsonProperty("is_pin_set")
    private String isPinSet;
    
    @JsonProperty("last_name")
    private String lastName;
    
    @JsonProperty("msisdn")
    private String msisdn;
    
    @JsonProperty("reg_status")
    private String regStatus;
    
    @JsonProperty("registration")
    private Registration registration;

    public Data() {
    }
    
    

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getIsBarred() {
        return isBarred;
    }

    public void setIsBarred(String isBarred) {
        this.isBarred = isBarred;
    }

    public String getIsPinSet() {
        return isPinSet;
    }

    public void setIsPinSet(String isPinSet) {
        this.isPinSet = isPinSet;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    public String getRegStatus() {
        return regStatus;
    }

    public void setRegStatus(String regStatus) {
        this.regStatus = regStatus;
    }

    public Registration getRegistration() {
        return registration;
    }

    public void setRegistration(Registration registration) {
        this.registration = registration;
    }
    
    
    
}
