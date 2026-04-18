package com.equitybank.drplatform.security;

import com.equitybank.drplatform.entity.UserEntity;
import com.equitybank.drplatform.enums.UserRole;
import com.equitybank.drplatform.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;

import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.*;
import java.util.Hashtable;
import java.util.Optional;

@Component
@RequiredArgsConstructor
@Slf4j
public class LdapAuthProvider implements AuthenticationProvider {

    private final UserRepository userRepository;

    @Value("${spring.ldap.urls}")
    private String ldapUrl;

    @Value("${spring.ldap.base}")
    private String ldapBase;

    @Value("${app.ldap.user-search-filter}")
    private String userSearchFilter;

    @Value("${app.ldap.user-search-base}")
    private String userSearchBase;

    @Value("${app.ldap.dev-mode:false}")
    private boolean devMode;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String email = authentication.getName();
        String password = authentication.getCredentials().toString();

        if (password == null || password.isBlank()) {
            throw new BadCredentialsException("Password cannot be empty");
        }

        if (devMode) {
            return authenticateDevMode(email, password);
        }

        try {
            // Attempt LDAP bind
            String userDn = buildUserDn(email);
            DirContext ctx = bindUser(userDn, password);

            // Load or create user in local DB
            UserEntity user = loadOrCreateUser(email, userDn, ctx);
            ctx.close();

            DrPlatformUserDetails userDetails = new DrPlatformUserDetails(user);
            return new UsernamePasswordAuthenticationToken(userDetails, password, userDetails.getAuthorities());

        } catch (NamingException e) {
            log.warn("LDAP authentication failed for {}: {}", email, e.getMessage());
            throw new BadCredentialsException("Invalid credentials");
        }
    }

    /**
     * Dev-mode: skips LDAP bind. Looks up the user in the local DB by email.
     * Any non-blank password is accepted. NEVER enable in production.
     */
    private Authentication authenticateDevMode(String email, String password) {
        log.warn("DEV MODE AUTH — LDAP bypassed for: {}", email);
        UserEntity user = userRepository.findByEmail(email)
                .orElseThrow(() -> new BadCredentialsException(
                        "No user with email '" + email + "' found in local DB. " +
                        "Insert a user via SQL or run Flyway migrations first."));
        if (!user.isActive()) {
            throw new BadCredentialsException("Account is deactivated");
        }
        DrPlatformUserDetails userDetails = new DrPlatformUserDetails(user);
        return new UsernamePasswordAuthenticationToken(userDetails, password, userDetails.getAuthorities());
    }

    private String buildUserDn(String email) {
        // Try sAMAccountName (email prefix) or full email bind
        String username = email.contains("@") ? email.split("@")[0] : email;
        return userSearchFilter.replace("{0}", username) + "," + userSearchBase + "," + ldapBase;
    }

    private DirContext bindUser(String userDn, String password) throws NamingException {
        Hashtable<String, String> env = new Hashtable<>();
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, ldapUrl + "/" + ldapBase);
        env.put(Context.SECURITY_AUTHENTICATION, "simple");
        env.put(Context.SECURITY_PRINCIPAL, userDn);
        env.put(Context.SECURITY_CREDENTIALS, password);
        env.put("com.sun.jndi.ldap.connect.timeout", "5000");
        return new InitialDirContext(env);
    }

    private UserEntity loadOrCreateUser(String email, String ldapDn, DirContext ctx) throws NamingException {
        Optional<UserEntity> existing = userRepository.findByEmail(email);
        if (existing.isPresent()) {
            UserEntity user = existing.get();
            if (!user.isActive()) {
                throw new BadCredentialsException("Account is deactivated");
            }
            return user;
        }

        // First-time login — create user with default APP_OWNER role
        // Coordinator must elevate via admin panel
        UserEntity newUser = UserEntity.builder()
                .email(email)
                .ldapDn(ldapDn)
                .displayName(extractDisplayName(ctx, email))
                .role(UserRole.APP_OWNER)
                .subsidiaryId("KE") // default — coordinator updates
                .isActive(true)
                .build();

        return userRepository.save(newUser);
    }

    private String extractDisplayName(DirContext ctx, String email) {
        try {
            String username = email.split("@")[0];
            SearchControls sc = new SearchControls();
            sc.setSearchScope(SearchControls.SUBTREE_SCOPE);
            sc.setReturningAttributes(new String[]{"displayName", "cn"});
            NamingEnumeration<SearchResult> results =
                    ctx.search(userSearchBase, "(sAMAccountName=" + username + ")", sc);
            if (results.hasMore()) {
                Attributes attrs = results.next().getAttributes();
                Attribute dn = attrs.get("displayName");
                if (dn != null) return dn.get().toString();
                Attribute cn = attrs.get("cn");
                if (cn != null) return cn.get().toString();
            }
        } catch (NamingException e) {
            log.debug("Could not extract displayName from LDAP: {}", e.getMessage());
        }
        return email.split("@")[0]; // fallback
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
    }
}
