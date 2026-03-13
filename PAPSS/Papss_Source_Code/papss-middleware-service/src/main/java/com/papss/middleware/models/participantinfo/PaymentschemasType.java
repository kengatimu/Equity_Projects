package com.papss.middleware.models.participantinfo;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;
import lombok.Data;

import java.util.List;

@Data
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "paymentschemasType", propOrder = {
        "paymentschemas"
})
public class PaymentschemasType {

    @XmlElement(name = "paymentschema")
    protected List<String> paymentschemas;
}
