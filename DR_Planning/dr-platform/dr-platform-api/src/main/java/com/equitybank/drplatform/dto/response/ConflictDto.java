package com.equitybank.drplatform.dto.response;

import com.equitybank.drplatform.entity.CampaignConflictEntity;
import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ConflictDto {
    private UUID id;
    private UUID campaignId;
    private String conflictType;
    private UUID[] applicationIds;
    private String description;
    private String recommendation;
    private String resolution;
    private String resolutionReason;
    private UUID resolvedById;
    private Instant resolvedAt;
    private Instant createdAt;

    public static ConflictDto fromEntity(CampaignConflictEntity e) {
        return ConflictDto.builder()
                .id(e.getId())
                .campaignId(e.getCampaignId())
                .conflictType(e.getConflictType())
                .applicationIds(e.getApplicationIds())
                .description(e.getDescription())
                .recommendation(e.getRecommendation())
                .resolution(e.getResolution())
                .resolutionReason(e.getResolutionReason())
                .resolvedById(e.getResolvedById())
                .resolvedAt(e.getResolvedAt())
                .createdAt(e.getCreatedAt())
                .build();
    }
}
