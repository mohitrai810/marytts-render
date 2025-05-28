FROM python:3.9
RUN pip install TTS
CMD ["tts-server", "--model_name", "tts_models/multilingual/multi-dataset/xtts_v2"]
