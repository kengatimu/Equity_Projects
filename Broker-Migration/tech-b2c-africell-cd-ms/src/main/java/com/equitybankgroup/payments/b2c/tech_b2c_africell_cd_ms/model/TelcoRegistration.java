/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import jakarta.persistence.*;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "drc_telco_registrations", indexes = {
    @Index(name = "idx_drc_telco_msisdn", columnList = "msisdn")
})
@Cache(usage = CacheConcurrencyStrategy.READ_ONLY)
public class TelcoRegistration
        implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "drc_telco_registrations_seq")
    @SequenceGenerator(name = "drc_telco_registrations_seq", sequenceName = "drc_telco_registrations_seq", allocationSize = 10)
    private Long id;
    
    @Column(name = "telco")
    private String telco;
    
    @Column(name = "country_code")
    private String countryCode;
    
    @Column(name = "msisdn", unique = false)
    private String msisdn;
    
    @Column(name = "first_name")
    private String firstName;
    
    @Column(name = "last_name")
    private String lastName;
    
    @Column(name = "id_number")
    private String idNumber;
    
    @Column(name = "source_account_number")
    private String sourceAccountNumber;
    
    @Column(name = "registration_id")
    private String registrationId;
    
    @Lob
    @Column(name = "request_payload")
    private String requestPayload;
    
    @Column(name = "currency")
    private String currency;
    
    @Lob
    @Column(name = "response_payload")
    private String responsePayload;
    
    @Column(name = "status")
    private String status;
    
    @Column(name = "grade")
    private String grade;
    
    @Column(name = "is_pin_set")
    private boolean isPinSet;
    
    @Column(name = "is_barred")
    private boolean isBarred;
    
    @Column(name = "is_active")
    private boolean isActive;
    
    @Column(name = "date_created")
    private LocalDateTime dateCreated;
    
    @Column(name = "date_updated")
    private LocalDateTime dateUpdated;
    
    @PrePersist
    public void onCreate() {
        LocalDateTime currentDateTime = LocalDateTime.now(ZoneId.of("GMT+3"));

        // Assign the LocalDateTime to dateCreated and dateUpdated. Also truncate the nanoseconds
        dateCreated = currentDateTime.truncatedTo(ChronoUnit.SECONDS);
        dateUpdated = currentDateTime.truncatedTo(ChronoUnit.SECONDS);
    }

    @PreUpdate
    public void onUpdate() {
        LocalDateTime currentDateTime = LocalDateTime.now(ZoneId.of("GMT+3"));

        // Assign the LocalDateTime to dateCreated and dateUpdated. Also truncate the nanoseconds
        dateUpdated = currentDateTime.truncatedTo(ChronoUnit.SECONDS);
    }

    public TelcoRegistration() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTelco() {
        return telco;
    }

    public void setTelco(String telco) {
        this.telco = telco;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public String getMsisdn() {
        return msisdn;
    }

    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public boolean getIsPinSet() {
        return isPinSet;
    }

    public void setIsPinSet(boolean isPinSet) {
        this.isPinSet = isPinSet;
    }

    public boolean isIsBarred() {
        return isBarred;
    }

    public void setIsBarred(boolean isBarred) {
        this.isBarred = isBarred;
    }

    public LocalDateTime getDateCreated() {
        return dateCreated;
    }

    public String getSourceAccountNumber() {
        return sourceAccountNumber;
    }

    public void setSourceAccountNumber(String sourceAccountNumber) {
        this.sourceAccountNumber = sourceAccountNumber;
    }

    public String getRegistrationId() {
        return registrationId;
    }

    public void setRegistrationId(String registrationId) {
        this.registrationId = registrationId;
    }
    
    

//    public void setDateCreated(LocalDateTime dateCreated) {
//        this.dateCreated = dateCreated;
//    }

    public LocalDateTime getDateUpdated() {
        return dateUpdated;
    }

//    public void setDateUpdated(LocalDateTime dateUpdated) {
//        this.dateUpdated = dateUpdated;
//    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRequestPayload() {
        return requestPayload;
    }

    public void setRequestPayload(String requestPayload) {
        this.requestPayload = requestPayload;
    }

    public String getResponsePayload() {
        return responsePayload;
    }

    public void setResponsePayload(String responsePayload) {
        this.responsePayload = responsePayload;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }
    
    
    
    
}
