package com.equitybank.drplatform.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MfaVerifyRequest {

    /** Opaque session token returned by /login when MFA is required */
    @NotBlank(message = "MFA session is required")
    private String mfaSession;

    @NotBlank(message = "TOTP code is required")
    @Size(min = 6, max = 6, message = "TOTP code must be exactly 6 digits")
    private String code;
}
