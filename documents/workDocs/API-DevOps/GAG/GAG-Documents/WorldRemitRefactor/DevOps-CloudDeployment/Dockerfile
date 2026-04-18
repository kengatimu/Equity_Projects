FROM adoptopenjdk:11-jdk-hotspot
VOLUME /tmp
EXPOSE 8701
ARG JAR_FILE
COPY target/world-remit-business-service-0.0.1-SNAPSHOT.jar app.jar
COPY applicationinsights-agent-3.4.5.jar applicationinsights-agent-3.4.5.jar
COPY applicationinsights-uat.json applicationinsights.json
ENV JAVA_OPTS=""
ENTRYPOINT exec java $JAVA_OPTS \
 -Djava.security.egd=file:/dev/./urandom \
 -Dspring.profiles.active=$SPRING_PROFILE \
 -javaagent:applicationinsights-agent-3.4.5.jar \
 -jar app.jar
