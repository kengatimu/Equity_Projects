package com.equitybank.gag.telco_b2c.web.rest.controller.token;

import com.equitybank.gag.telco_b2c.security.TokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/")
public class TokenController {
    private final String userName;
    private final String userPassword;
    private final TokenService tokenService;

    // Expiration time in seconds (300 seconds equals 5 minutes)
    private static final long TOKEN_EXPIRY_SEC = 300;

    @Autowired
    public TokenController(@Value("${security.user.username}") String userName,
                           @Value("${security.user.password}") String userPassword,
                           TokenService tokenService) {
        this.userName = userName;
        this.userPassword = userPassword;
        this.tokenService = tokenService;
    }

    @PostMapping("token")
    public ResponseEntity<Map<String, Object>> generateToken(@RequestParam String grant_type,
                                                             @RequestParam String username,
                                                             @RequestParam String password) {

        System.out.println("Received Generate Token Request: ");
        if (!"password".equals(grant_type)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("error", "Invalid grant_type"));
        }

        // Replace with real user validation logic
        if (userName.equals(username) && userPassword.equals(password)) {
            String token = tokenService.generateToken(username, TOKEN_EXPIRY_SEC);
            return ResponseEntity.ok(Map.of(
                    "access_token", token,
                    "token_type", "bearer",
                    "expires_in", TOKEN_EXPIRY_SEC
            ));
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(Map.of("error", "Invalid username or password"));
    }
}
