FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests
FROM eclipse-temurin:17-jre
WORKDIR /app
RUN useradd --system --uid 1001 appuser
COPY --from=build /app/target/student-api-0.0.1-SNAPSHOT.jar app.jar
COPY global-bundle.pem /app/global-bundle.pem
USER 1001
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
