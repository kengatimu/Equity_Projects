package com.equitybank.gag.papss.ots.entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.OffsetDateTime;

@Entity
@Table(name = "papss_sender_details")
public class SenderDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "papss_sender_details_seq")
    @SequenceGenerator(name = "papss_sender_details_seq", sequenceName = "papss_sender_details_seq", allocationSize = 10)
    private Long id;

    @Version
    @Column(name = "version")
    private Long version;

    @Column(name = "rrn", unique = true, nullable = false)
    private String rrn;

    @Column(name = "institution_id", length = 20)
    private String institutionId;

    @Column(length = 20)
    private String bic;

    @Column(name = "country_code", length = 5)
    private String countryCode;

    @Column(length = 5)
    private String currency;

    @Column(name = "account_number", length = 30)
    private String accountNumber;

    @Column(name = "account_name", length = 100)
    private String accountName;

    @Column(name = "address")
    private String address;

    @Column(name = "created_at", nullable = false)
    private OffsetDateTime createdAt;

    // Relationship with TransactionMaster (1:1)
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "rrn", referencedColumnName = "rrn", insertable = false, updatable = false)
    private TransactionMaster transaction;

    public Long getId() {
        return id;
    }

    public Long getVersion() {
        return version;
    }

    public void setVersion(Long version) {
        this.version = version;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRrn() {
        return rrn;
    }

    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    public String getInstitutionId() {
        return institutionId;
    }

    public void setInstitutionId(String institutionId) {
        this.institutionId = institutionId;
    }

    public String getBic() {
        return bic;
    }

    public void setBic(String bic) {
        this.bic = bic;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(OffsetDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public TransactionMaster getTransaction() {
        return transaction;
    }

    public void setTransaction(TransactionMaster transaction) {
        this.transaction = transaction;
    }
}
