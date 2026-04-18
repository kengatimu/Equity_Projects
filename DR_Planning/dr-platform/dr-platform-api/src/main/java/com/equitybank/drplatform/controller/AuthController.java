package com.equitybank.drplatform.controller;

import com.equitybank.drplatform.dto.request.LoginRequest;
import com.equitybank.drplatform.dto.request.MfaVerifyRequest;
import com.equitybank.drplatform.dto.request.RequestOtpRequest;
import com.equitybank.drplatform.dto.request.VerifyOtpRequest;
import com.equitybank.drplatform.dto.response.ApiResponse;
import com.equitybank.drplatform.dto.response.AuthResponse;
import com.equitybank.drplatform.service.AuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<AuthResponse>> login(@Valid @RequestBody LoginRequest req) {
        return ResponseEntity.ok(ApiResponse.success(authService.login(req)));
    }

    @PostMapping("/mfa/verify")
    public ResponseEntity<ApiResponse<AuthResponse>> verifyMfa(@Valid @RequestBody MfaVerifyRequest req) {
        return ResponseEntity.ok(ApiResponse.success(authService.verifyMfa(req)));
    }

    @PostMapping("/refresh")
    public ResponseEntity<ApiResponse<AuthResponse>> refresh(
            @RequestHeader("X-Refresh-Token") String refreshToken) {
        return ResponseEntity.ok(ApiResponse.success(authService.refreshToken(refreshToken)));
    }

    @PostMapping("/logout")
    public ResponseEntity<ApiResponse<Void>> logout(
            @RequestHeader("X-Refresh-Token") String refreshToken) {
        authService.logout(refreshToken);
        return ResponseEntity.ok(ApiResponse.success(null, "Logged out successfully"));
    }

    /** Email OTP — step 1: request a verification code */
    @PostMapping("/request-otp")
    public ResponseEntity<ApiResponse<java.util.Map<String, Object>>> requestOtp(
            @Valid @RequestBody RequestOtpRequest req) {
        boolean delivered = authService.requestOtp(req.getEmail());
        String message = delivered
                ? "Verification code sent to " + req.getEmail()
                : "Code generated but email delivery failed";
        return ResponseEntity.ok(ApiResponse.success(
                java.util.Map.of("emailDelivered", delivered), message));
    }

    /** Email OTP — step 2: verify the code and receive JWT tokens */
    @PostMapping("/verify-otp")
    public ResponseEntity<ApiResponse<AuthResponse>> verifyOtp(@Valid @RequestBody VerifyOtpRequest req) {
        return ResponseEntity.ok(ApiResponse.success(authService.verifyOtp(req.getEmail(), req.getCode())));
    }
}
