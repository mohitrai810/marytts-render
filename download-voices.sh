#!/bin/bash

# Create voices directory if it doesn't exist
mkdir -p lib/voices/

# Download Hindi voice (cmu-slt-hsmm) - Updated URL
wget https://github.com/marytts/voice-cmu-slt-hsmm/releases/download/v5.2.1/voice-cmu-slt-hsmm-5.2.jar -P lib/voices/

# Optional: Add other voices (uncomment if needed)
wget https://github.com/marytts/voice-dfki-pavoque-neutral-hsmm/releases/download/v5.2.1/voice-dfki-pavoque-neutral-hsmm-5.2.jar -P lib/voices/
