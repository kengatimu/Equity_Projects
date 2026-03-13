package com.papss.middleware.service.outbound.domains.credittransfer;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.papss.middleware.enums.TransactionChannel;
import com.papss.middleware.utils.RegularExpressions;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import javax.xml.parsers.SAXParser;
import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CreditTransferRequest {

    @NotNull(message = "endToEndRef cannot be blank")
    private String endToEndRef;

    @NotNull(message = "tranDateTime cannot be blank")
   // @Pattern(regexp = RegularExpressions.ISODATE, message = "tranDateTime is not a valid ISO date")
    private String tranDateTime;

    @NotNull(message = "narration cannot be blank")
    //@Pattern(regexp= RegularExpressions.ALPHANUMERIC, message="narration Can Only Be Alphanumeric")
    @Size(max = 140)
    private String narration;


    @NotNull(message = "isInvoice cannot be blank")
    @JsonProperty("isInvoice")
    private Boolean isInvoice;

    @NotNull(message = "categoryPurpose cannot be blank")
    @Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "categoryPurpose can only be alphanumeric of type ")
    private String categoryPurpose;

    @NotNull(message = "localInstrumentType cannot be blank")
    @Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "localInstrumentType can only be alphanumeric of type ET, SSA3 or USDP")
    private String localInstrumentType;

    @DecimalMin(value = "0.00", inclusive = false)
    @Digits(integer = 100, fraction = 2)
    private BigDecimal amount;

    @NotNull(message = "Sender Cannot Be Blank")
    @Valid
    private TransferDetails sender;

    @NotNull(message = "Receiver Cannot Be Blank")
    @Valid
    private TransferDetails receiver;

    private String instId;
    private String transRef;

    @NotNull(message = "transactionChannel cannot be blank. Available values: CORE_BANKING, INTERNET_BANKING, MOBILE_BANKING, POS, ATM, BRANCH, API, USSD, SWITCH, BULK_TRANSFER, MIDDLEWARE, CHATBOT, CALL_CENTER, WALLET, AGENT_NETWORK, CARD_PAYMENT, QR_CODE, PAYMENT_LINK")
    private TransactionChannel transactionChannel;
}
