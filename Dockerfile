# Build stage
FROM maven:3.9.6-eclipse-temurin-21@sha256:8d63d4c1902cb12d9e79a70671b18ebe26358cb592561af33ca1808f00d935cb AS build
WORKDIR /app
COPY pom.xml .
# Download dependencies separately to leverage Docker layer cache
RUN mvn dependency:go-offline -q
COPY src ./src
RUN mvn package -DskipTests -q

# Runtime stage
FROM dhi.io/eclipse-temurin:21-alpine3.22@sha256:46904f8b10ff29d5f4e8ffc762e59df663a92ef254b2b855401297350b9607a0
WORKDIR /app
COPY --from=build /app/target/demo-app1-*.jar app.jar
EXPOSE 8080
USER 1001
ENTRYPOINT ["java", "-jar", "app.jar"]
