package com.papss.middleware.service.outbound.domains.nameenquiry;

import com.papss.middleware.dto.nameinquiry.NameInquiryReceiver;
import com.papss.middleware.dto.nameinquiry.NameInquirySender;
import com.papss.middleware.utils.RegularExpressions;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NameInquiryRequest {

    @NotNull(message = "Sender Cannot Be Blank")
    @Valid
    private NameInquirySender sender;

    @NotNull(message = "Receiver Cannot Be Blank")
    @Valid
    private NameInquiryReceiver receiver;

    @NotNull(message = "EndToEndRef Cannot Be Blank")
    @Size(min = 4, max = 60, message = "Invalid Character length")
    @Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "TransRef Can Only Be Alphanumeric")
    private String endToEndRef;
}
