/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.airtel;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *
 * @author ronaldcheruiyot
 */
public class CustomerData {
    @JsonProperty("first_name")
    private String first_name;
    
    @JsonProperty("grade")
    private String grade;
    
    @JsonProperty("is_barred")
    private Boolean is_barred;
    
    @JsonProperty("is_pin_set")
    private Boolean is_pin_set;
    
    @JsonProperty("last_name")
    private String last_name;
    
    @JsonProperty("msisdn")
    private String msisdn;
    
    @JsonProperty("reg_status")
    private String reg_status;
    
    @JsonProperty("registration")
    private Registration registration;

    public CustomerData() {
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public Boolean getIs_barred() {
        return is_barred;
    }

    public void setIs_barred(Boolean is_barred) {
        this.is_barred = is_barred;
    }

    public Boolean getIs_pin_set() {
        return is_pin_set;
    }

    public void setIs_pin_set(Boolean is_pin_set) {
        this.is_pin_set = is_pin_set;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    public String getReg_status() {
        return reg_status;
    }

    public void setReg_status(String reg_status) {
        this.reg_status = reg_status;
    }

    public Registration getRegistration() {
        return registration;
    }

    public void setRegistration(Registration registration) {
        this.registration = registration;
    }
    
    

    
    
    
    
}
