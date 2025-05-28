FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libsndfile1 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install torch torchaudio --index-url https://download.pytorch.org/whl/cpu && \
    pip install TTS==0.22.0

# Create a simple server script
RUN echo "from TTS.server.server import main; main()" > /app/server.py

EXPOSE 5002

CMD ["python", "/app/server.py", "--model_name", "tts_models/multilingual/multi-dataset/xtts_v2"]
