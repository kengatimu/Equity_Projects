package com.equitybankgroup.payments.b2c.model;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "Telco_B2C_Param_Configs")
public class ParamConfigs implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "param_seq")
    @SequenceGenerator(name = "param_seq", sequenceName = "param_seq", allocationSize = 10)
    private Long id;

    @Column(name = "config_id", unique = true)
    private String configId;

    @Lob
    @Column(name = "config_value")
    private String configValue;

    @Lob
    @Column(name = "config_bin_value")
    private String configBinValue;

    @Column(name = "config_desc")
    private String configDesc;

    @Column(name = "config_status")
    private String configStatus;

    @Column(name = "deleted")
    private String deleted;

    @PrePersist
    public void onCreate() {
        configStatus = "ENABLED";
        deleted = "N";
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getConfigId() {
        return configId;
    }

    public void setConfigId(String configId) {
        this.configId = configId;
    }

    public String getConfigValue() {
        return configValue;
    }

    public void setConfigValue(String configValue) {
        this.configValue = configValue;
    }

    public String getConfigBinValue() {
        return configBinValue;
    }

    public void setConfigBinValue(String configBinValue) {
        this.configBinValue = configBinValue;
    }

    public String getConfigDesc() {
        return configDesc;
    }

    public void setConfigDesc(String configDesc) {
        this.configDesc = configDesc;
    }

    public String getConfigStatus() {
        return configStatus;
    }

    public void setConfigStatus(String configStatus) {
        this.configStatus = configStatus;
    }

    public String getDeleted() {
        return deleted;
    }

    public void setDeleted(String deleted) {
        this.deleted = deleted;
    }
}
