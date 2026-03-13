package com.equitybank.gag.telco_b2c.security;

import io.jsonwebtoken.Claims;

public interface TokenService {
    String generateToken(String username, long tokenExpirySec);

    Claims validateToken(String token);
}
