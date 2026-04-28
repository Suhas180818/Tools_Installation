FROM ubuntu:24.04 AS Stage01
WORKDIR /app
COPY pom.xml .

RUN sudo apt update && \
    sudo apt install -y maven 
    
COPY src ./app/src
RUN mvn clean package  


FROM openjdk:17-slim AS Stage02 
WORKDIR /app    
COPY --from=Stage01 /app/target/*.jar app.jar
EXPOSE 9999
ENTRYPOINT ["java", "-jar", "app.jar"]




    
    
    


