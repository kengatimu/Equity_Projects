package com.equitybank.drplatform.dto.request;

import com.equitybank.drplatform.enums.UserRole;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CreateUserRequest {
    @NotBlank @Email(message = "Valid email required")
    private String email;

    @NotBlank(message = "Display name is required")
    private String displayName;

    @NotNull(message = "Role is required")
    private UserRole role;

    @NotBlank(message = "Subsidiary ID is required")
    private String subsidiaryId;

    private String lineManagerEmail;
}
