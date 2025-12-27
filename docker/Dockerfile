# ---------- Stage 1: Builder / Test-runner ----------
FROM python:3.10-slim AS builder

WORKDIR /app

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc && \
    rm -rf /var/lib/apt/lists/*

COPY pyproject.toml ./
COPY src ./src
COPY tests ./tests

RUN python -m pip install --no-cache-dir --upgrade pip && \
    (python -m pip install --no-cache-dir -e ".[test]" || \
     (python -m pip install --no-cache-dir -e . && python -m pip install --no-cache-dir pytest))

CMD ["pytest", "-v"]

# ---------- Stage 2: Runtime ----------
FROM python:3.10-slim AS runtime

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && \
    apt-get install -y --no-install-recommends libpq5 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

COPY --from=builder /app/src /app/src

RUN find /usr/local/lib/python3.10/site-packages -name '__pycache__' -type d -exec rm -rf {} + \
 && find /usr/local/lib/python3.10/site-packages -name '*.pyc' -type f -delete

RUN useradd -u 1000 appuser && \
    chown -R appuser:appuser /app
USER appuser

EXPOSE 8052

CMD ["python", "-m", "uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8052"]