FROM debian:bullseye-20191118

RUN apt-get update \
 && apt-get install --yes \
    curl \
    unzip

RUN curl -Ss --output /tmp/ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip \
 && unzip /tmp/ngrok.zip -d /usr/bin \
 && rm /tmp/ngrok.zip
