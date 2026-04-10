# Build stage
FROM maven:3.9.6-eclipse-temurin-21@sha256:8d63d4c1902cb12d9e79a70671b18ebe26358cb592561af33ca1808f00d935cb AS build
WORKDIR /app
COPY pom.xml .
# Download dependencies separately to leverage Docker layer cache
RUN mvn dependency:go-offline -q
COPY src ./src
RUN mvn package -DskipTests -q

# Runtime stage
FROM docker.io/eclipse-temurin:21-jre-alpine-3.23@sha256:6ad8ed080d9be96b61438ec3ce99388e294af216ed57356000c06070e85c5d5d
WORKDIR /app
COPY --from=build /app/target/demo-app1-*.jar app.jar
EXPOSE 8080
USER 1001
ENTRYPOINT ["java", "-jar", "app.jar"]
