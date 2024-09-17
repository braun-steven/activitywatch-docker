FROM debian:bookworm-slim

LABEL maintainer="Steven Braun <steven.braun.mz@gmail.com>"
LABEL repository="https://github.com/braun-steven/activitywatch-docker/edit/master/Dockerfile"

RUN mkdir /app
WORKDIR /app

RUN apt-get -qq -y update \
  && apt-get install -qq -y --no-install-recommends ca-certificates unzip wget \
  && wget $(curl -s https://api.github.com/repos/activitywatch/activitywatch/releases/latest | grep "browser_download_url.*li
nux-x86_64.zip" | cut -d '"' -f 4) \
  && unzip ./activitywatch*.zip \
  && rm ./activitywatch*.zip \
  && chmod +x ./activitywatch/aw-server \
  && apt-get purge -qq -y --auto-remove ca-certificates unzip wget

EXPOSE 5600
SHELL ["/bin/bash", "-c"]
CMD ["/app/activitywatch/aw-server", "--host", "0.0.0.0"]
