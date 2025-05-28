FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libsndfile1 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Install MeloTTS (no license prompts)
RUN pip install melotts

EXPOSE 8000

CMD ["melotts", "serve", "--host", "0.0.0.0", "--port", "8000"]
