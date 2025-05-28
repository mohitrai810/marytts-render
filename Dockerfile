FROM python:3.10-slim

WORKDIR /app

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

# Pre-download model with auto-accepted license
RUN python -c "from TTS.utils.manage import ModelManager; ModelManager().download_model('tts_models/multilingual/multi-dataset/xtts_v2')"

# Create server script that bypasses license prompt
RUN echo "from TTS.utils.manage import ModelManager; \
ModelManager().download_model('tts_models/multilingual/multi-dataset/xtts_v2'); \
from TTS.server.server import main; main()" > server.py

EXPOSE 5002

CMD ["python", "server.py", "--model_name", "tts_models/multilingual/multi-dataset/xtts_v2"]
