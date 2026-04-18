
package com.equitybank.payments.imt.b2c.drcbroker.domain;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import javax.annotation.Generated;
import javax.persistence.*;

import com.equitybank.payments.imt.b2c.drcbroker.domain.enumeration.ResponseStatusCode;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Entity
@Table(name = "status_details")
@Generated("jsonschema2pojo")
public class StatusDetails implements Serializable {
    private final static long serialVersionUID = 2422561938381469159L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceKeyGeneratorBroker")
    @SequenceGenerator(name = "sequenceKeyGeneratorBroker")
    @Column(name = "id")
    @SerializedName("id")
    @Expose
    private Integer id;

    @Column(name = "tran_status")
    @SerializedName("status")
    @Expose
    private String status;

    @Column(name = "status_code")
    @SerializedName("statusCode")
    @Expose
    private String statusCode;

    @Column(name = "status_description")
    @SerializedName("statusDescription")
    @Expose
    private String statusDescription;

    @Column(name = "status_message")
    @SerializedName("statusMessage")
    @Expose
    private String statusMessage;

    @OneToOne (mappedBy = "transactionStatusDetails",
            fetch = FetchType.LAZY,
            cascade = {
                    CascadeType.DETACH,
                    CascadeType.MERGE,
                    CascadeType.PERSIST,
                    CascadeType.REFRESH
            })
//    @Expose //don,t expose, otherwise it will loop forever causing stackoverflow exception
    private TransactionDetails transactionDetails;;

    @PrePersist
    public void onCreate() {
        //initial status
        status = String.valueOf(ResponseStatusCode.PERSISTED);

        //initial status message
        statusMessage = "Transaction Persisted. Waiting For Initial Response From PCES Broker";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusDescription() {
        return statusDescription;
    }

    public void setStatusDescription(String statusDescription) {
        this.statusDescription = statusDescription;
    }

    public String getStatusMessage() {
        return statusMessage;
    }

    public void setStatusMessage(String statusMessage) {
        this.statusMessage = statusMessage;
    }

    public TransactionDetails getTransactionDetails() {
        return transactionDetails;
    }

    public void setTransactionDetails(TransactionDetails transactionDetails) {
        this.transactionDetails = transactionDetails;
    }

    @Override
    public String toString() {
        return "TransactionStatusDetails{" +
                "id=" + id +
                ", status='" + status + '\'' +
                ", statusCode='" + statusCode + '\'' +
                ", statusDescription='" + statusDescription + '\'' +
                ", statusMessage='" + statusMessage + '\'' +
                ", transactionDetails=" + transactionDetails +
                '}';
    }
}
