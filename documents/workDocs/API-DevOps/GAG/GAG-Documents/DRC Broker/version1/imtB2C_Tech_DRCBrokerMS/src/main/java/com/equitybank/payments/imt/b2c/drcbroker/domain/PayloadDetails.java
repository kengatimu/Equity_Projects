
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
@Table(name = "payload_details")
@Generated("jsonschema2pojo")
public class PayloadDetails implements Serializable {
    private final static long serialVersionUID = 7691715660027430876L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceKeyGeneratorBroker")
    @SequenceGenerator(name = "sequenceKeyGeneratorBroker")
    @Column(name = "id")
    @SerializedName("id")
    @Expose
    private Long id;

    @Lob
    @Column(name = "business_service_request")
    @SerializedName("businessServiceRequest")
    @Expose
    private String businessServiceRequest;

    @Lob
    @Column(name = "business_service_initial_res")
    @SerializedName("businessServiceInitialResponse")
    @Expose
    private String businessServiceInitialResponse;

    @Lob
    @Column(name = "business_service_final_res")
    @SerializedName("businessServiceFinalResponse")
    @Expose
    private String businessServiceFinalResponse;

    @Lob
    @Column(name = "broker_request")
    @SerializedName("brokerRequest")
    @Expose
    private String brokerRequest;

    @Lob
    @Column(name = "broker_initial_res")
    @SerializedName("brokerInitialResponse")
    @Expose
    private String brokerInitialResponse;

    @Lob
    @Column(name = "broker_final_res")
    @SerializedName("brokerFinalResponse")
    @Expose
    private String brokerFinalResponse;

    @OneToOne (mappedBy = "payloadDetails",
            fetch = FetchType.LAZY,
            cascade = {
                    CascadeType.DETACH,
                    CascadeType.MERGE,
                    CascadeType.PERSIST,
                    CascadeType.REFRESH
            })
//    @Expose //don,t expose, otherwise it will loop forever causing stackoverflow exception
    private TransactionDetails transactionDetails;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBusinessServiceRequest() {
        return businessServiceRequest;
    }

    public void setBusinessServiceRequest(String businessServiceRequest) {
        this.businessServiceRequest = businessServiceRequest;
    }

    public String getBusinessServiceInitialResponse() {
        return businessServiceInitialResponse;
    }

    public void setBusinessServiceInitialResponse(String businessServiceInitialResponse) {
        this.businessServiceInitialResponse = businessServiceInitialResponse;
    }

    public String getBusinessServiceFinalResponse() {
        return businessServiceFinalResponse;
    }

    public void setBusinessServiceFinalResponse(String businessServiceFinalResponse) {
        this.businessServiceFinalResponse = businessServiceFinalResponse;
    }

    public String getBrokerRequest() {
        return brokerRequest;
    }

    public void setBrokerRequest(String brokerRequest) {
        this.brokerRequest = brokerRequest;
    }

    public String getBrokerInitialResponse() {
        return brokerInitialResponse;
    }

    public void setBrokerInitialResponse(String brokerInitialResponse) {
        this.brokerInitialResponse = brokerInitialResponse;
    }

    public String getBrokerFinalResponse() {
        return brokerFinalResponse;
    }

    public void setBrokerFinalResponse(String brokerFinalResponse) {
        this.brokerFinalResponse = brokerFinalResponse;
    }

    public TransactionDetails getTransactionDetails() {
        return transactionDetails;
    }

    public void setTransactionDetails(TransactionDetails transactionDetails) {
        this.transactionDetails = transactionDetails;
    }

    @Override
    public String toString() {
        return "PayloadDetails{" +
                "id=" + id +
                ", businessServiceRequest='" + businessServiceRequest + '\'' +
                ", businessServiceInitialResponse='" + businessServiceInitialResponse + '\'' +
                ", businessServiceFinalResponse='" + businessServiceFinalResponse + '\'' +
                ", brokerRequest='" + brokerRequest + '\'' +
                ", brokerInitialResponse='" + brokerInitialResponse + '\'' +
                ", brokerFinalResponse='" + brokerFinalResponse + '\'' +
                ", transactionDetails=" + transactionDetails +
                '}';
    }
}
