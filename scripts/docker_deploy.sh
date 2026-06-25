#!/bin/bash
set -e
docker build -t adk-ai-platform:latest .
if [ "$(docker ps -aq -f name=adk-ai-agent-container)" ]; then
    docker rm -f adk-ai-agent-container
fi
docker run -d -p 8000:8000 --name adk-ai-agent-container adk-ai-platform:latest
