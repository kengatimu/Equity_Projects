package com.papss.middleware.models.fxrate;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@XmlRootElement(name = "PaymentFXRate")
@XmlAccessorType(XmlAccessType.FIELD)
public class PaymentFXRate implements Serializable {
    private static final long serialVersionUID = 1L;

    @XmlElement(name = "Request")
    private FxRequest fxRequest;
    @XmlElement(name = "Response")
    private FxResponse fxResponse;

//    public String getExchangeRate() {
//        String senderCurrencyCode = fxRequest.getSenderCurrency();
//        String receiverCurrencyCode = fxRequest.getReceiverCurrency();
//        String exchangeRateTypeKey = String.format("%s/%s", senderCurrencyCode, receiverCurrencyCode);
//        return Arrays.stream(fxResponse.getRate()).filter(rate -> rate.getType().equalsIgnoreCase(exchangeRateTypeKey)).findFirst().map(Rate::getValue).orElseThrow(NullPointerException::new);
//    }
}
