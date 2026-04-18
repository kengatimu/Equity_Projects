
package com.equitybank.payments.imt.b2c.drcbroker.domain;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;
import javax.annotation.Generated;
import javax.persistence.*;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Entity
@Table(name = "sender_details")
@Generated("jsonschema2pojo")
public class SenderDetails implements Serializable {
    private final static long serialVersionUID = -9196032725332158350L;

    @Id
    @Column(name = "sender_phone")
    @SerializedName("senderPhone")
    @Expose
    private String senderPhone;

    @Column(name = "sender_name")
    @SerializedName("senderName")
    @Expose
    private String senderName;

    //do not apply cascade delete
    @Expose
    @OneToMany(mappedBy = "senderDetails",
            fetch = FetchType.LAZY,
            cascade = {
                    CascadeType.DETACH,
                    CascadeType.MERGE,
                    CascadeType.PERSIST,
                    CascadeType.REFRESH
            })
    private List<TransactionDetails> transactionDetails;

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getSenderPhone() {
        return senderPhone;
    }

    public void setSenderPhone(String senderPhone) {
        this.senderPhone = senderPhone;
    }

    public List<TransactionDetails> getTransactionDetails() {
        return transactionDetails;
    }

    public void setTransactionDetails(List<TransactionDetails> transactionDetails) {
        this.transactionDetails = transactionDetails;
    }

    //convenient method for adding transaction details
    public void addTransactionDetail(TransactionDetails tranDetails) {
        if (transactionDetails == null)
            transactionDetails = new ArrayList<>();
        transactionDetails.add(tranDetails);

        //for bidirectional
        tranDetails.setSenderDetails(this);
    }

    @Override
    public String toString() {
        return "SenderDetails{" +
                "senderPhone='" + senderPhone + '\'' +
                ", senderName='" + senderName + '\'' +
                ", transactionDetails=" + transactionDetails +
                '}';
    }
}
