FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the build.gradle and settings.gradle files first
# for better cache utilization during Docker build
COPY build.gradle settings.gradle ./

COPY gradlew gradlew
COPY gradle gradle

RUN ./gradlew dependencies

COPY src src

RUN ./gradlew build

COPY build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
