FROM openjdk:11-jre-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://github.com/marytts/marytts/releases/download/v5.2/marytts-5.2.zip && \
    unzip marytts-5.2.zip && \
    mv marytts-5.2/* . && \
    rm -rf marytts-5.2 marytts-5.2.zip

EXPOSE 59125

CMD ["java", "-Xmx1024m", "-cp", "lib/*:target/marytts-5.2.jar", "marytts.server.Mary"]
