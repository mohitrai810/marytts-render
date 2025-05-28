FROM openjdk:11-jre-slim

WORKDIR /app

# Install MaryTTS + Hindi language pack
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://github.com/marytts/marytts/releases/download/v5.2/marytts-5.2.zip && \
    unzip marytts-5.2.zip && \
    mv marytts-5.2/* . && \
    rm -rf marytts-5.2 marytts-5.2.zip && \
    wget https://github.com/marytts/marytts-lang-hi/releases/download/v5.2/marytts-lang-hi-5.2.jar -P lib/

EXPOSE 59125

CMD ["java", "-Xmx2g", "-cp", "lib/*:target/marytts-5.2.jar", "marytts.server.Mary"]
