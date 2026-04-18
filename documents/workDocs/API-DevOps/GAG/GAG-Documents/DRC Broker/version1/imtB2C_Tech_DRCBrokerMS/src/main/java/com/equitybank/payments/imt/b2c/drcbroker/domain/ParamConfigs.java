package com.equitybank.payments.imt.b2c.drcbroker.domain;

import com.google.gson.annotations.Expose;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;

/**
 * A BrokerParamConfigs.
 */
@Entity
@Table(name = "broker_param_configs")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class ParamConfigs implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceKeyGeneratorBroker")
    @SequenceGenerator(name = "sequenceKeyGeneratorBroker")
    @Expose
    private Long id;

    @Column(name = "config_id", unique = true)
    @Expose
    private String configId;

    @Size(max = 3000)
    @Column(name = "config_value", length = 3000)
    @Expose
    private String configValue;

    @Lob
    @Column(name = "config_bin_value")
    @Expose
    private String configBinValue;

    @Column(name = "config_desc")
    @Expose
    private String configDesc;

    @Column(name = "config_status")
    @Expose
    private String configStatus;

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

    @Override
    public String toString() {
        return "BrokerParamConfigs{" +
                "id=" + id +
                ", configId='" + configId + '\'' +
                ", configValue='" + configValue + '\'' +
                ", configBinValue='" + configBinValue + '\'' +
                ", configDesc='" + configDesc + '\'' +
                ", configStatus='" + configStatus + '\'' +
                '}';
    }
}
