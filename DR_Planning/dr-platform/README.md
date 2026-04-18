# Equity Bank DR Management Platform

A centralised Disaster Recovery management platform for Equity Group Holdings, covering campaign lifecycle management, runbook enforcement, checklist tracking, dependency conflict detection, and real-time war-room coordination across all subsidiaries.

---

## Project Structure

```
dr-platform/
├── dr-platform-api/          Spring Boot 3.2 / Java 21 backend
│   ├── src/main/java/...     All source code
│   └── src/main/resources/
│       ├── application.yml   Base configuration
│       └── db/migration/     Flyway V1–V7 SQL migrations
├── dr-platform-frontend/     React 18 / TypeScript / Vite frontend
│   └── src/
│       ├── api/              Axios client with token refresh
│       ├── context/          AuthContext (LDAP/JWT)
│       ├── hooks/            React Query hooks
│       ├── pages/            All application pages
│       └── components/       Shared UI components
└── tanuki/                   Java Service Wrapper deployment
    ├── wrapper.conf          Tanuki configuration
    ├── drplatform.sh         Start/stop script (Linux)
    └── application-production.yml  Production config template
```

---

## Prerequisites

| Tool | Version |
|------|---------|
| Java | 21 (LTS) |
| Maven | 3.9+ |
| Node.js | 20.x LTS |
| PostgreSQL | 16 |
| Redis | 7.x |
| Tanuki Java Service Wrapper | 3.5.x Community or Standard |

---

## Development Setup

### 1. Database

```sql
CREATE DATABASE dr_platform;
CREATE USER dr_platform_app WITH PASSWORD 'changeme';
GRANT ALL PRIVILEGES ON DATABASE dr_platform TO dr_platform_app;
```

### 2. Backend

```bash
cd dr-platform-api

# Copy and edit configuration
cp src/main/resources/application.yml src/main/resources/application-local.yml
# Edit application-local.yml: set DB password, LDAP URL, JWT secret

# Run with local profile
mvn spring-boot:run -Dspring-boot.run.profiles=local
```

The API starts on **http://localhost:8080**

Flyway automatically runs migrations V1–V7 on first start.

### 3. Frontend

```bash
cd dr-platform-frontend

npm install
npm run dev
```

The dev server starts on **http://localhost:5173** and proxies `/api` → `http://localhost:8080`.

---

## Building for Production

```bash
# Build everything (API jar + frontend static files bundled inside)
cd dr-platform
mvn clean package -Pproduction

# Output: dr-platform-api/target/dr-platform-api-1.0.0-SNAPSHOT.jar
```

---

## Production Deployment (Tanuki Java Service Wrapper)

### 1. Install Tanuki Wrapper

Download the Java Service Wrapper from https://wrapper.tanukisoftware.com/ and place the binaries:

```
tanuki/
├── wrapper          (wrapper executable — Linux/Mac)
├── wrapper.exe      (Windows)
├── libwrapper.so    (Linux) / libwrapper.dylib (Mac) / wrapper.dll (Windows)
└── wrapper.jar      (Wrapper JAR — must be on JVM classpath)
```

### 2. Prepare directory layout

```
/opt/equitybank/dr-platform/
├── tanuki/              (wrapper binaries + conf from this repo)
├── dr-platform-api/
│   └── target/
│       └── dr-platform-api-1.0.0-SNAPSHOT.jar
├── config/
│   └── application-production.yml    (copy & fill from tanuki/ template)
├── logs/                (auto-created)
└── run/                 (PID file location — auto-created)
```

### 3. Set environment variables

```bash
export DB_PASSWORD="..."
export LDAP_BIND_DN="cn=svc-drplatform,ou=service,dc=equitybank,dc=internal"
export LDAP_BIND_PASSWORD="..."
export JWT_SECRET="<random 512-bit hex>"
export REDIS_PASSWORD="..."
export MAIL_USERNAME="..."
export MAIL_PASSWORD="..."
```

Or inject them via your organisation's secrets manager (HashiCorp Vault, etc.).

### 4. Start / Stop

```bash
cd /opt/equitybank/dr-platform/tanuki

chmod +x drplatform.sh

./drplatform.sh start     # Start
./drplatform.sh stop      # Graceful shutdown
./drplatform.sh restart   # Rolling restart
./drplatform.sh status    # Check if running
```

### 5. Install as system service (Linux)

```bash
./drplatform.sh install   # Registers with init.d / systemd

# Then:
systemctl enable drplatform
systemctl start drplatform
```

### 6. Install as Windows service

```cmd
tanuki\wrapper.exe -i tanuki\wrapper.conf
net start drplatform
```

---

## API Reference (key endpoints)

| Method | Path | Description |
|--------|------|-------------|
| POST | `/api/auth/login` | LDAP login → JWT + refresh token |
| POST | `/api/auth/mfa/verify` | OTP verification |
| POST | `/api/auth/refresh` | Silent token refresh |
| GET  | `/api/dashboard` | Role-aware dashboard data |
| GET  | `/api/applications` | Paginated application search |
| POST | `/api/applications/import` | Excel bulk import |
| GET  | `/api/campaigns` | List campaigns |
| POST | `/api/campaigns` | Create campaign |
| POST | `/api/campaigns/{id}/open-pre-dr` | Open Pre-DR window |
| POST | `/api/campaigns/{id}/approve` | Approve campaign |
| GET  | `/api/campaigns/{id}/gate-check` | Check approval gate |
| GET  | `/api/campaign-applications/{caId}/checklist` | Get checklist |
| POST | `/api/campaign-applications/{caId}/checklist/sign-off` | Submit sign-off |
| GET  | `/api/campaigns/{id}/conflicts` | List dependency conflicts |
| POST | `/api/conflicts/{id}/resolve` | Resolve conflict |

---

## Security

- Authentication: **LDAP bind** via Spring LDAP, JWT access tokens (15 min), refresh tokens (8 hr SHA-256 hashed)
- Authorisation: **RBAC** via `@PreAuthorize` — 8 roles (SUPER_ADMIN → EXTERNAL_PARTICIPANT)
- Transport: All endpoints require HTTPS in production
- Security headers: HSTS, X-Frame-Options DENY, Content-Security-Policy
- Audit log: All mutations are recorded via AOP `@Auditable` → immutable `audit_log` partitioned table

---

## Default Credentials (development only)

A seed SUPER_ADMIN user is inserted by Flyway `V6__initial_data.sql`. Change the password immediately after first login.

---

## Phase Roadmap

| Phase | Weeks | Scope |
|-------|-------|-------|
| **1 (current)** | 1–6 | Auth, application registry, campaign manager, checklist, dashboard |
| 2 | 7–10 | War-room coordination, live status board, notifications (email/SMS) |
| 3 | 11–14 | Analytics, PDF runbook export, executive reporting, ITSCM portal |
| 4 | 15–16 | UAT, hardening, load testing, go-live |
