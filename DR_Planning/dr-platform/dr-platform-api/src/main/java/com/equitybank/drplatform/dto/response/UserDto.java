package com.equitybank.drplatform.dto.response;

import com.equitybank.drplatform.entity.UserEntity;
import com.equitybank.drplatform.enums.UserRole;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {
    private UUID id;
    private String email;
    private String displayName;
    private UserRole role;
    private String subsidiaryId;
    private String lineManagerEmail;
    @JsonProperty("isActive")
    private boolean isActive;
    private Instant lastLogin;
    private Instant createdAt;

    public static UserDto fromEntity(UserEntity e) {
        return UserDto.builder()
                .id(e.getId())
                .email(e.getEmail())
                .displayName(e.getDisplayName())
                .role(e.getRole())
                .subsidiaryId(e.getSubsidiaryId())
                .lineManagerEmail(e.getLineManagerEmail())
                .isActive(e.isActive())
                .lastLogin(e.getLastLogin())
                .createdAt(e.getCreatedAt())
                .build();
    }
}
