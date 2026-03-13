package com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction;
import java.io.Serializable;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "sender",
        "receiver"
})
public class Parties implements Serializable {
    private final static long serialVersionUID = -2324542004184873911L;

    @Valid
    @NotNull(message = "sender party is mandatory")
    @JsonProperty("sender")
    private Sender sender;

    @Valid
    @NotNull(message = "receiver party is mandatory")
    @JsonProperty("receiver")
    private Receiver receiver;

    @JsonProperty("sender")
    public Sender getSender() {
        return sender;
    }

    @JsonProperty("sender")
    public void setSender(Sender sender) {
        this.sender = sender;
    }

    @JsonProperty("receiver")
    public Receiver getReceiver() {
        return receiver;
    }

    @JsonProperty("receiver")
    public void setReceiver(Receiver receiver) {
        this.receiver = receiver;
    }

}

