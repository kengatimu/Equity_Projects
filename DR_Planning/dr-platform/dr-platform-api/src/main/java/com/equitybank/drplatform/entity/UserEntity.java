package com.equitybank.drplatform.entity;

import com.equitybank.drplatform.enums.UserRole;
import jakarta.persistence.*;
import lombok.*;

import java.time.Instant;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserEntity extends AuditableEntity {

    @Column(name = "ldap_dn", length = 500)
    private String ldapDn;

    @Column(name = "email", unique = true, nullable = false, length = 200)
    private String email;

    @Column(name = "display_name", nullable = false, length = 200)
    private String displayName;

    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false, length = 50)
    private UserRole role;

    @Column(name = "subsidiary_id", nullable = false, length = 10)
    private String subsidiaryId;

    @Column(name = "line_manager_email", length = 200)
    private String lineManagerEmail;

    @Column(name = "is_active")
    @Builder.Default
    private boolean isActive = true;

    @Column(name = "last_login")
    private Instant lastLogin;
}
