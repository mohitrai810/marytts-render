#!/bin/bash

# Download Hindi voice (cmu-slt-hsmm)
wget https://github.com/marytts/voice-cmu-slt-hsmm/releases/download/v5.2/voice-cmu-slt-hsmm-5.2.jar -P lib/voices/

# Optional: Add more voices (e.g., French, German)
wget https://github.com/marytts/voice-dfki-pavoque-neutral-hsmm/releases/download/v5.2/voice-dfki-pavoque-neutral-hsmm-5.2.jar -P lib/voices/
