package com.equitybank.drplatform.dto.response;

import lombok.*;

import java.util.List;
import java.util.UUID;

/**
 * Aggregated view of a shared infrastructure resource (e.g. a database)
 * and every application that depends on it.
 *
 * Returned by GET /api/dependencies/shared — used by the Dependency Engine
 * page to show the "Shared Resources" grid and by conflict detection to
 * highlight DR scheduling risks.
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SharedResourceSummaryDto {

    /** The canonical resource name, e.g. "ORACLE_DG_PRIMARY", "KAFKA_PROD" */
    private String resourceName;

    /** DependencyType enum string: DATABASE, MIDDLEWARE, NETWORK, API, … */
    private String dependencyType;

    /** Number of applications that share this resource */
    private int applicationCount;

    /** Apps that depend on this resource */
    private List<AppRef> applications;

    @Getter
    @Setter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class AppRef {
        private UUID applicationId;
        private String applicationName;
        private String applicationCode;
        private String applicationTier;
        /** The DependencyEntity.id — used by DELETE /api/dependencies/{id} */
        private UUID dependencyId;
        private String description;
    }
}
