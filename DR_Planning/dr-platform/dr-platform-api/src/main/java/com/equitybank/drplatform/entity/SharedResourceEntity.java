package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;

/**
 * Infrastructure Resource Registry (CMDB-lite).
 *
 * An infrastructure resource is any component that one or more applications
 * depend on: a database cluster, a message broker, a VPN gateway, an auth
 * service, etc.  When two or more apps share the same resource, it becomes
 * a potential DR scheduling conflict point.
 *
 * {@code code} is the canonical identifier (e.g. ORACLE_OMNI_PROD).
 * The DB enforces case-insensitive uniqueness via a functional index on
 * UPPER(code), so "oracle_omni_prod" and "ORACLE_OMNI_PROD" cannot coexist.
 * This eliminates the naming-drift problem that plagues free-text fields.
 */
@Entity
@Table(name = "infrastructure_resources")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SharedResourceEntity extends AuditableEntity {

    /**
     * Canonical code — the single source of truth.
     * Format: UPPERCASE_SNAKE (enforced by the application layer + DB index).
     * Examples: ORACLE_OMNI_PROD, KAFKA_CLUSTER_PROD, ACTIVEMQ_GROUP, AD_AUTH
     */
    @Column(name = "code", nullable = false, length = 50)
    private String code;

    /** Human-readable display name, e.g. "Oracle Omni Production DB" */
    @Column(name = "name", nullable = false, length = 200)
    private String name;

    /** DependencyType enum value: DATABASE, MIDDLEWARE, NETWORK, API, AUTH, DNS, VPN, OTHER */
    @Column(name = "resource_type", nullable = false, length = 50)
    private String resourceType;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    /** Primary host or connection string (informational, not secret) */
    @Column(name = "host", columnDefinition = "TEXT")
    private String host;

    /** PRODUCTION (default) | DR | STAGING */
    @Column(name = "environment", length = 20)
    @Builder.Default
    private String environment = "PRODUCTION";

    @Column(name = "is_active")
    @Builder.Default
    private boolean isActive = true;
}
