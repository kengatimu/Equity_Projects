package com.equitybank.drplatform.dto.request;

import com.equitybank.drplatform.enums.ChecklistItemStatus;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateChecklistItemStatusRequest {

    @NotNull(message = "Status is required")
    private ChecklistItemStatus status;

    private String notes;
}
