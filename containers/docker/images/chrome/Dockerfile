FROM debian:stretch

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y wget

#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /google-chrome-stable_current_amd64.deb

COPY google-chrome-stable_current_amd64.deb /
RUN apt install -y /google-chrome-stable_current_amd64.deb

# RUN apt-get -f install