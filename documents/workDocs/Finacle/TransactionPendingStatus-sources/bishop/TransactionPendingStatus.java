
package bishop;

import java.io.Serializable;
import javax.annotation.Generated;

@Generated("jsonschema2pojo")
public class TransactionPendingStatus implements Serializable
{

    private String requestId;
    private String tranStatus;
    private String tranStatusCode;
    private String tranStatusDesc;
    private String statusCountIpsl;
    private String statusCountCbs;
    private String dateCreated;
    private String dateUpdated;
    private final static long serialVersionUID = -2481832337860208047L;

    public String getRequestId() {
        return requestId;
    }

    public void setRequestId(String requestId) {
        this.requestId = requestId;
    }

    public String getTranStatus() {
        return tranStatus;
    }

    public void setTranStatus(String tranStatus) {
        this.tranStatus = tranStatus;
    }

    public String getTranStatusCode() {
        return tranStatusCode;
    }

    public void setTranStatusCode(String tranStatusCode) {
        this.tranStatusCode = tranStatusCode;
    }

    public String getTranStatusDesc() {
        return tranStatusDesc;
    }

    public void setTranStatusDesc(String tranStatusDesc) {
        this.tranStatusDesc = tranStatusDesc;
    }

    public String getStatusCountIpsl() {
        return statusCountIpsl;
    }

    public void setStatusCountIpsl(String statusCountIpsl) {
        this.statusCountIpsl = statusCountIpsl;
    }

    public String getStatusCountCbs() {
        return statusCountCbs;
    }

    public void setStatusCountCbs(String statusCountCbs) {
        this.statusCountCbs = statusCountCbs;
    }

    public String getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(String dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getDateUpdated() {
        return dateUpdated;
    }

    public void setDateUpdated(String dateUpdated) {
        this.dateUpdated = dateUpdated;
    }

}
