package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "checklist_blockers", indexes = {
    @Index(name = "idx_blocker_item", columnList = "checklist_item_id"),
    @Index(name = "idx_blocker_raised_by", columnList = "raised_by_id")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChecklistBlockerEntity extends BaseEntity {

    @Column(name = "checklist_item_id", nullable = false)
    private UUID checklistItemId;

    @Column(name = "description", columnDefinition = "TEXT", nullable = false)
    private String description;

    @Column(name = "severity", length = 20)
    @Builder.Default
    private String severity = "MEDIUM";

    @Column(name = "escalated_to", length = 200)
    private String escalatedTo;

    @Column(name = "raised_by_id")
    private UUID raisedById;

    @Column(name = "resolved_by_id")
    private UUID resolvedById;

    @Column(name = "resolved_at")
    private LocalDateTime resolvedAt;

    @Column(name = "resolution_notes", columnDefinition = "TEXT")
    private String resolutionNotes;
}
