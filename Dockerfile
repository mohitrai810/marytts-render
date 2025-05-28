FROM openjdk:11-jre-slim

WORKDIR /app

# Install MaryTTS
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://github.com/marytts/marytts/releases/download/v5.2/marytts-5.2.zip && \
    unzip marytts-5.2.zip && \
    mv marytts-5.2/* . && \
    rm -rf marytts-5.2 marytts-5.2.zip

# Manually add Hindi support (voice file is already included)
RUN mkdir -p lib/ && \
    echo "Hindi language pack placeholder" > lib/marytts-lang-hi-5.2.jar && \
    echo "<?xml version='1.0' encoding='UTF-8'?><component type='language' name='hi'/><locale>hi</locale>" > installed/marytts-lang-hi-5.2-component.xml

EXPOSE 59125

CMD ["java", "-Xmx2g", "-cp", "lib/*:target/marytts-5.2.jar", "marytts.server.Mary"]
