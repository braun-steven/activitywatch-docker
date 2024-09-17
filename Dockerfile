FROM debian:bookworm-slim

LABEL maintainer="Steven Braun <steven.braun.mz@gmail.com>"
LABEL repository="https://github.com/braun-steven/activitywatch-docker"

ENV VERSION=0.13.1

WORKDIR /app

RUN apt-get update -qq -y

RUN apt-get install -qq -y --no-install-recommends \
    ca-certificates \
    unzip \
    wget

RUN wget https://github.com/ActivityWatch/activitywatch/releases/download/v${VERSION}/activitywatch-v${VERSION}-linux-x86_64.zip

RUN unzip activitywatch-v${VERSION}-linux-x86_64.zip

RUN rm activitywatch-v${VERSION}-linux-x86_64.zip

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN chmod +x ./activitywatch/aw-server

EXPOSE 5600

CMD ["/app/activitywatch/aw-server", "--host", "0.0.0.0"]
