package com.equitybank.drplatform.controller;

import com.equitybank.drplatform.dto.request.CreateUserRequest;
import com.equitybank.drplatform.dto.response.ApiResponse;
import com.equitybank.drplatform.dto.response.PagedResponse;
import com.equitybank.drplatform.dto.response.UserDto;
import com.equitybank.drplatform.enums.UserRole;
import com.equitybank.drplatform.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @PostMapping
    @PreAuthorize("hasRole('SUPER_ADMIN')")
    public ResponseEntity<ApiResponse<UserDto>> createUser(@Valid @RequestBody CreateUserRequest req) {
        return ResponseEntity.status(201).body(ApiResponse.success(userService.createUser(req)));
    }

    @GetMapping
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<PagedResponse<UserDto>>> listUsers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(required = false) String subsidiaryId,
            @RequestParam(required = false) UserRole role) {
        return ResponseEntity.ok(ApiResponse.success(userService.listUsers(page, size, subsidiaryId, role)));
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<UserDto>> getUser(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(userService.getUser(id)));
    }

    @PatchMapping("/{id}/role")
    @PreAuthorize("hasRole('SUPER_ADMIN')")
    public ResponseEntity<ApiResponse<UserDto>> updateRole(
            @PathVariable UUID id,
            @RequestParam UserRole role) {
        return ResponseEntity.ok(ApiResponse.success(userService.updateRole(id, role)));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('SUPER_ADMIN')")
    public ResponseEntity<ApiResponse<Void>> deactivateUser(@PathVariable UUID id) {
        userService.deactivateUser(id);
        return ResponseEntity.ok(ApiResponse.success(null, "User deactivated"));
    }

    @GetMapping("/me")
    public ResponseEntity<ApiResponse<UserDto>> getCurrentUser() {
        return ResponseEntity.ok(ApiResponse.success(userService.getCurrentUser()));
    }
}
