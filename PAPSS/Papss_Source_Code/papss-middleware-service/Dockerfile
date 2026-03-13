FROM eclipse-temurin:21-jdk-alpine

# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Install curl
RUN apk update && apk add --no-cache curl

# Switch to non-root user
USER appuser

# Set working directory (must be writable by appuser)
WORKDIR /app

# Copy the jar file
COPY --chown=appuser:appgroup target/*.jar app.jar

# Set environment variables
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom"

EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
