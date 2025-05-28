FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libsndfile1 \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install MeloTTS from GitHub
RUN pip install git+https://github.com/myshell-ai/MeloTTS.git

EXPOSE 8000

CMD ["melotts", "serve", "--host", "0.0.0.0", "--port", "8000"]
