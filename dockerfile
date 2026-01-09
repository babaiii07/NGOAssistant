FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install system deps
RUN apt-get update && apt-get install -y gcc \
    && rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . .

# Create non-root user
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

# Render uses PORT env variable
EXPOSE 10000

# Health check (Render-compatible)
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD python - <<EOF || exit 1
import os, urllib.request
port = os.getenv("PORT", "10000")
urllib.request.urlopen(f"http://localhost:{port}/api/health")
EOF

# Start Gunicorn
CMD gunicorn app:app \
    --bind 0.0.0.0:$PORT \
    --workers 1 \
    --threads 2 \
    --timeout 120
