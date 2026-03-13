package com.equitybank.gag.dummy_telco_b2c_ms.controller;

import com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.token.TokenRes;
import com.equitybank.gag.dummy_telco_b2c_ms.security.TokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
public class TokenController {
    private final String userName;
    private final String userPassword;
    private final TokenService tokenService;

    // Expiration time in seconds
    private static final long TOKEN_EXPIRY_SEC = 10;

    @Autowired
    public TokenController(@Value("${security.user.username}") String userName,
                           @Value("${security.user.password}") String userPassword,
                           TokenService tokenService) {
        this.userName = userName;
        this.userPassword = userPassword;
        this.tokenService = tokenService;
    }

    @GetMapping("oauth/v1")
    public ResponseEntity<?> generateToken(@RequestParam String username,
                                                             @RequestParam String password) {

        System.out.println("Received Generate Token Request");
        System.out.println("Received Username: " + username);
        System.out.println("Received Password: " + password);

        // Replace with real user validation logic
        if (userName.equals(username) && userPassword.equals(password)) {
            String token = tokenService.generateToken(username, TOKEN_EXPIRY_SEC);
            System.out.println("Token: " + token);
            TokenRes tokenRes = mapTokenValues(token);
            return new ResponseEntity<>(tokenRes, HttpStatus.OK);
        }

        TokenRes tokenErrorRes = mapTokenErrorValues();
        System.out.println("Token: " + "invalid_credentials");
        return new ResponseEntity<>(tokenErrorRes, HttpStatus.OK);
    }

    private TokenRes mapTokenValues(String token) {
        TokenRes tokenRes = new TokenRes();
        tokenRes.setAccess_token(token);
        tokenRes.setToken_type("Bearer");
        tokenRes.setExpiry_date(String.valueOf(TOKEN_EXPIRY_SEC*1000));
        tokenRes.setStatus(0);
        return tokenRes;
    }

    private TokenRes mapTokenErrorValues() {
        TokenRes tokenRes = new TokenRes();
        tokenRes.setAccess_token("invalid_credentials");
        tokenRes.setToken_type("Bearer");
        tokenRes.setExpiry_date(null);
        tokenRes.setStatus(-1);
        return tokenRes;
    }
}
