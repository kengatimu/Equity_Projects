# Dockerfile Improvements

## Overview
This document outlines the improvements made to the Dockerfile for the PAPSS Middleware Service. The changes focus on security, performance, maintainability, and adherence to Docker best practices.

## Key Improvements

### 1. Multi-stage Build
**Before:** Single-stage build that included the JDK and all build tools in the final image.
**After:** Two-stage build process:
- First stage: Builds the application using JDK
- Second stage: Only includes the JRE and the built JAR file

**Benefits:**
- Significantly smaller final image size (JRE vs JDK)
- Reduced attack surface by not including build tools in the production image
- Cleaner separation of build and runtime environments

### 2. Layer Optimization
**Before:** All files copied at once, causing cache invalidation on any file change.
**After:** Strategic ordering of operations:
1. Copy Maven wrapper and POM first
2. Download dependencies
3. Copy source code
4. Build application

**Benefits:**
- Better utilization of Docker's layer caching
- Faster builds when only source code changes
- Reduced network usage by not re-downloading dependencies unnecessarily

### 3. Enhanced Java Options
**Before:** Basic Java options with only `-Djava.security.egd=file:/dev/./urandom`
**After:** Comprehensive JVM tuning:
```
-Djava.security.egd=file:/dev/./urandom -XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -XX:+UseG1GC -Dspring.config.location=/app/config/application.yml
```

**Benefits:**
- Container-aware memory settings with `-XX:+UseContainerSupport`
- More efficient memory usage with percentage-based limits
- Better garbage collection with G1GC
- Explicit configuration location

### 4. Health Check
**Before:** No health check in the Dockerfile (only in docker-compose.yml)
**After:** Added HEALTHCHECK directive:
```
HEALTHCHECK --interval=30s --timeout=10s --retries=3 --start-period=10s \
  CMD curl -f http://localhost:8080/actuator/health || exit 1
```

**Benefits:**
- Container orchestrators can monitor application health
- Automatic restart of unhealthy containers
- Better visibility into application status

### 5. Metadata with Labels
**Before:** No metadata labels
**After:** Added descriptive labels:
```
LABEL maintainer="PAPSS Team"
LABEL version="1.0"
LABEL description="PAPSS Middleware Service"
```

**Benefits:**
- Better documentation
- Improved container management and filtering
- Clearer ownership information

### 6. Security Enhancements
**Before:** Basic security with non-root user
**After:** Enhanced security:
- Still using non-root user
- Explicit directory creation with proper permissions
- Reduced attack surface with multi-stage build
- Proper file ownership with `--chown` flag

**Benefits:**
- Minimized risk of privilege escalation
- Better control over file permissions
- Reduced attack surface

### 7. Proper ENTRYPOINT and CMD Separation
**Before:** Using only CMD
**After:** Separated ENTRYPOINT and CMD:
```
ENTRYPOINT ["java"]
CMD ["-jar", "app.jar"]
```

**Benefits:**
- Better clarity of the container's purpose
- Easier to override Java options at runtime
- More aligned with Docker best practices

### 8. Directory Structure
**Before:** Simple directory structure
**After:** Created directories that match the volume mounts in docker-compose.yml:
```
RUN mkdir -p /app/config /var/papss/certs && \
    chown -R appuser:appgroup /app /var/papss/certs
```

**Benefits:**
- Ensures proper permissions for mounted volumes
- Prevents runtime permission issues
- Better alignment with the deployment configuration

## Conclusion
These improvements make the Dockerfile more efficient, secure, and maintainable. The multi-stage build significantly reduces the image size, while the layer optimization speeds up the build process. The enhanced Java options and health check improve runtime performance and reliability. The security enhancements and proper directory structure ensure that the container runs securely and efficiently in production.