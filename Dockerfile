FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    LUCIDADL_MUSIC=/downloads \
    LUCIDADL_HOME=/data

# xvfb: ecrã virtual, para o Chromium correr "com janela" (o Cloudflare costuma
# rejeitar o modo headless puro)
RUN apt-get update \
    && apt-get install -y --no-install-recommends xvfb xauth \
    && rm -rf /var/lib/apt/lists/*

# Instala a partir do PyPI e descarrega o Chromium + dependências de sistema
RUN pip install lucidadl \
    && playwright install --with-deps chromium \
    && rm -rf /var/lib/apt/lists/*

# Pasta de trabalho: é aqui que o programa procura ./inputs/tracks.txt, etc.
WORKDIR /app

VOLUME ["/downloads", "/data", "/app/inputs"]

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
