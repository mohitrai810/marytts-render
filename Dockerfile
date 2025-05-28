FROM openjdk:11-jre-slim

WORKDIR /app

# Install only MaryTTS (no Hindi dependencies yet)
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://github.com/marytts/marytts/releases/download/v5.2.1/marytts-5.2.1.zip && \
    unzip marytts-5.2.1.zip && \
    mv marytts-5.2.1/* . && \
    rm -rf marytts-5.2.1 marytts-5.2.1.zip

# Manually enable Hindi for existing voice (cmu-slt-hsmm)
RUN sed -i 's|<locale>en_US</locale>|<locale>en_US</locale><locale>hi</locale>|' installed/voice-cmu-slt-hsmm-5.2.1-component.xml && \
    echo "<?xml version='1.0'?><component type='language' name='hi'><locale>hi</locale></component>" > installed/marytts-lang-hi-5.2.1-component.xml

EXPOSE 59125

CMD ["java", "-Xmx2g", "-cp", "lib/*:target/marytts-5.2.1.jar", "marytts.server.Mary"]
