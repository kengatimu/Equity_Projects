package com.equitybank.drplatform.dto.response;

import com.equitybank.drplatform.entity.ApplicationHistoryEntity;
import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ApplicationHistoryDto {
    private UUID    id;
    private String  code;
    private String  name;
    private String  tier;
    private String  subsidiaryId;
    private String  drCapability;
    private String  vendor;
    private String  techOwnerName;
    private String  techOwnerEmail;
    private Instant originalCreatedAt;
    private Instant originalUpdatedAt;
    private Instant archivedAt;
    private UUID    archivedById;
    private String  archivedByEmail;

    public static ApplicationHistoryDto fromEntity(ApplicationHistoryEntity e) {
        return ApplicationHistoryDto.builder()
                .id(e.getId())
                .code(e.getCode())
                .name(e.getName())
                .tier(e.getTier())
                .subsidiaryId(e.getSubsidiaryId())
                .drCapability(e.getDrCapability())
                .vendor(e.getVendor())
                .techOwnerName(e.getTechOwnerName())
                .techOwnerEmail(e.getTechOwnerEmail())
                .originalCreatedAt(e.getOriginalCreatedAt())
                .originalUpdatedAt(e.getOriginalUpdatedAt())
                .archivedAt(e.getArchivedAt())
                .archivedById(e.getArchivedById())
                .archivedByEmail(e.getArchivedByEmail())
                .build();
    }
}
