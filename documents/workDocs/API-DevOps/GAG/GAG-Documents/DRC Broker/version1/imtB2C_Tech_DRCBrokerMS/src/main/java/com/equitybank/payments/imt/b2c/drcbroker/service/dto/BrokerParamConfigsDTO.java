package com.equitybank.payments.imt.b2c.drcbroker.service.dto;

import com.equitybank.payments.imt.b2c.drcbroker.domain.ParamConfigs;

import javax.persistence.Lob;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the {@link ParamConfigs} entity.
 */
public class BrokerParamConfigsDTO implements Serializable {

    private Long id;
    private String configId;
    @Size(max = 3000)
    private String configValue;
    @Lob
    private String configBinValue;
    private String configDesc;
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
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof BrokerParamConfigsDTO)) {
            return false;
        }

        BrokerParamConfigsDTO businessParamConfigsDTO = (BrokerParamConfigsDTO) o;
        if (this.id == null) {
            return false;
        }
        return Objects.equals(this.id, businessParamConfigsDTO.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.id);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "BusinessParamConfigsDTO{" +
            "id=" + getId() +
            ", configId='" + getConfigId() + "'" +
            ", configValue='" + getConfigValue() + "'" +
            ", configBinValue='" + getConfigBinValue() + "'" +
            ", configDesc='" + getConfigDesc() + "'" +
            ", configStatus='" + getConfigStatus() + "'" +
            "}";
    }
}
