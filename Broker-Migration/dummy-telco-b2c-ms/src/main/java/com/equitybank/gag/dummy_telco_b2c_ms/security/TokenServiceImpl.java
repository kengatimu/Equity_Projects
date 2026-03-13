package com.equitybank.gag.dummy_telco_b2c_ms.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class TokenServiceImpl implements TokenService {
    private final String secretKey;

    public TokenServiceImpl(@Value("${security.jwt.secret-key}") String secretKey) {
        this.secretKey = secretKey;
    }

    @Override
    public String generateToken(String username, long tokenExpirySec) {
        // Generate a SecretKey from the secret string
        SecretKey key = new SecretKeySpec(secretKey.getBytes(), SignatureAlgorithm.HS256.getJcaName());

        // Set claims and expiration time
        Map<String, Object> claims = new HashMap<>();
        long expirationTime = tokenExpirySec * 1000L;  // Expiration time in milliseconds (300 seconds equals 5 minutes)
//        long expirationTime = tokenExpirySec * 1000000L;  // Expiration time in milliseconds (300 seconds equals 5 minutes)

        // Generate the token
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + expirationTime))
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
    }

    @Override
    public Claims validateToken(String token) {
        // Generate the key for validation
        SecretKey key = new SecretKeySpec(secretKey.getBytes(), SignatureAlgorithm.HS256.getJcaName());

        try {
            // Parse the JWT and get the claims
            return Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (JwtException e) {
            // If the token is invalid, return null
            return null;
        }
    }
}