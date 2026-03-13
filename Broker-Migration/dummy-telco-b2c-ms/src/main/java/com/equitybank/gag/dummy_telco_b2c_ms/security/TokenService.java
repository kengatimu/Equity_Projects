package com.equitybank.gag.dummy_telco_b2c_ms.security;

import io.jsonwebtoken.Claims;

public interface TokenService {
    String generateToken(String username, long tokenExpirySec);

    Claims validateToken(String token);
}
