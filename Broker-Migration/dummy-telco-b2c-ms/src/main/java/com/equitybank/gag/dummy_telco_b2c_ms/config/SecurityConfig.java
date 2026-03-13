package com.equitybank.gag.dummy_telco_b2c_ms.config;

import com.equitybank.gag.dummy_telco_b2c_ms.security.TokenValidationFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
public class SecurityConfig {

    private final TokenValidationFilter tokenValidationFilter;

    public SecurityConfig(TokenValidationFilter tokenValidationFilter) {
        this.tokenValidationFilter = tokenValidationFilter;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(authz -> authz
                        // Public endpoint
                        .requestMatchers("/token").permitAll()

                        // Token Authentication for specific endpoints
                        .requestMatchers("/api/v1/banktowallet/namecheck").authenticated()
                        .requestMatchers("/api/v1/floatpurchase/namecheck").authenticated()

                        // Basic Authentication for /api/v1/mtn/**
                        .requestMatchers("/api/v1/mtn/**").authenticated()

                        // Allow all other requests
                        .anyRequest().permitAll()
                )
                .httpBasic(httpBasic -> {}) // Enable Basic Auth
                .addFilterBefore(tokenValidationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        UserDetails user = User.builder()
                .username("login")
                .password(passwordEncoder().encode("password"))
                .build();
        return new InMemoryUserDetailsManager(user);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
