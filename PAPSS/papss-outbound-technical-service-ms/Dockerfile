FROM eclipse-temurin:24-jdk
WORKDIR /app

# Copy the JAR built by Maven from github action. Note: Not locally built
COPY target/papss-outbound-technical-service-ms-0.0.1-SNAPSHOT.jar app.jar

# Copy Elastic APM agent (optional)
COPY pipelines/apm/elastic-apm-agent-1.51.0.jar /app/apm/

# Copy configs
COPY pipelines/deploy/uat /app/deploy
COPY pipelines/java_env/uat /app/java_env

EXPOSE 10443

# Use SPRING_PROFILE env (vm profile for vm testing)
ENV SPRING_PROFILE=vm

ENTRYPOINT ["java", "-javaagent:/app/apm/elastic-apm-agent-1.51.0.jar", "-jar", "app.jar", "--spring.profiles.active=${SPRING_PROFILE}"]
