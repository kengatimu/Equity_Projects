package com.equitybank.drplatform.controller;

import com.equitybank.drplatform.dto.response.ApiResponse;
import com.equitybank.drplatform.dto.response.DashboardDto;
import com.equitybank.drplatform.security.DrPlatformUserDetails;
import com.equitybank.drplatform.service.DashboardService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/dashboard")
@RequiredArgsConstructor
public class DashboardController {

    private final DashboardService dashboardService;

    @GetMapping
    public ResponseEntity<ApiResponse<DashboardDto>> getDashboard(
            @AuthenticationPrincipal DrPlatformUserDetails user,
            @RequestParam(required = false) String subsidiaryId) {

        DashboardDto dashboard = switch (user.getUser().getRole()) {
            case SUPER_ADMIN, COORDINATOR, GROUP_COORDINATOR, MANAGEMENT, AUDITOR ->
                    dashboardService.getCoordinatorDashboard(user.getUser().getId(), subsidiaryId);
            case APP_OWNER, DR_PARTICIPANT, EXTERNAL_PARTICIPANT ->
                    dashboardService.getAppOwnerDashboard(user.getUser().getId());
        };

        return ResponseEntity.ok(ApiResponse.success(dashboard));
    }
}
