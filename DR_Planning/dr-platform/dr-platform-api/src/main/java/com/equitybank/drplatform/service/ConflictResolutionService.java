package com.equitybank.drplatform.service;

import com.equitybank.drplatform.dto.request.ResolveConflictRequest;
import com.equitybank.drplatform.dto.response.ConflictDto;
import com.equitybank.drplatform.entity.CampaignConflictEntity;
import com.equitybank.drplatform.exception.ResourceNotFoundException;
import com.equitybank.drplatform.repository.CampaignConflictRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class ConflictResolutionService {

    private final CampaignConflictRepository conflictRepository;

    public ConflictDto resolveConflict(UUID conflictId, ResolveConflictRequest request, UUID coordinatorId) {
        CampaignConflictEntity conflict = conflictRepository.findById(conflictId)
                .orElseThrow(() -> new ResourceNotFoundException("Conflict", conflictId));
        conflict.setResolution(request.getResolution());
        conflict.setResolutionReason(request.getReason());
        conflict.setResolvedById(coordinatorId);
        conflict.setResolvedAt(Instant.now());
        return ConflictDto.fromEntity(conflictRepository.save(conflict));
    }

    @Transactional(readOnly = true)
    public List<ConflictDto> getUnresolvedConflicts(UUID campaignId) {
        return conflictRepository.findUnresolvedByCampaignId(campaignId)
                .stream().map(ConflictDto::fromEntity).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ConflictDto> getAllConflicts(UUID campaignId) {
        return conflictRepository.findByCampaignId(campaignId)
                .stream().map(ConflictDto::fromEntity).collect(Collectors.toList());
    }
}
