#!/usr/bin/env bash
# Render start script

exec python3.11 -m uvicorn app:app --host 0.0.0.0 --port $PORT
