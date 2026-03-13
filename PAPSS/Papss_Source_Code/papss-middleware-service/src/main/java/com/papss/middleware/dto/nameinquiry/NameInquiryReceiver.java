package com.papss.middleware.dto.nameinquiry;

import com.papss.middleware.utils.RegularExpressions;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;


@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NameInquiryReceiver {

    @NotEmpty(message = "inst_id Field is Required")
    @Size(min = 4, max = 15, message = "Invalid Character length")
    @Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "Institution ID Can Only Be Alphanumeric")
    private String instId;

    //@NotEmpty(message = "inst_bic Field is Required")
  //  @Size(min = 4, max = 15, message = "Invalid Character length")
    //@Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "Institution BIC Can Only Be Alphanumeric")
    private String instBic;

    @NotEmpty(message = "Account Field is Required")
    @Size(min = 4, max = 50, message = "Invalid Account length")
    @Pattern(regexp = RegularExpressions.NUMERIC, message = "Account Can Only Be Digits")
    private String accountNumber;
}
