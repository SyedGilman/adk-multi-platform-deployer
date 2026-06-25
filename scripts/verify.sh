#!/bin/bash
if [ "$1" = "Docker" ]; then
    curl -s --retry 3 http://localhost:8000/ | grep -q "healthy" && echo "✅ Verified!"
else
    kubectl get pods -l app=adk-ai-agent
fi
