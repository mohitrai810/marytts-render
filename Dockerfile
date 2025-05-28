FROM openjdk:11-jre-slim

WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget unzip git maven

# Clone and build Hindi language support from official repo
RUN git clone https://github.com/marytts/marytts-lang-hi.git && \
    cd marytts-lang-hi && \
    mvn clean package && \
    mkdir -p ../lib/ && \
    cp target/marytts-lang-hi-5.2.1.jar ../lib/ && \
    cd .. && \
    rm -rf marytts-lang-hi

# Install MaryTTS (using working Maven Central link)
RUN wget https://repo1.maven.org/maven2/de/dfki/mary/marytts/5.2.1/marytts-5.2.1.zip && \
    unzip marytts-5.2.1.zip && \
    mv marytts-5.2.1/* . && \
    rm -rf marytts-5.2.1 marytts-5.2.1.zip

# Register Hindi components
RUN echo "<?xml version='1.0' encoding='UTF-8'?>" > installed/marytts-lang-hi-5.2.1-component.xml && \
    echo "<component type='language' name='hi' version='5.2.1'>" >> installed/marytts-lang-hi-5.2.1-component.xml && \
    echo "  <locale>hi</locale>" >> installed/marytts-lang-hi-5.2.1-component.xml && \
    echo "</component>" >> installed/marytts-lang-hi-5.2.1-component.xml

# Enable Hindi for the voice
RUN sed -i 's|<locale>en_US</locale>|<locale>en_US</locale><locale>hi</locale>|' installed/voice-cmu-slt-hsmm-5.2.1-component.xml

EXPOSE 59125

CMD ["java", "-Xmx2g", "-cp", "lib/*:target/marytts-5.2.1.jar", "marytts.server.Mary"]
