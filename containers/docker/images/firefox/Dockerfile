FROM debian:stretch

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y wget
    #apt-get install -y --no-install-recommends firefox-esr

# Firefox
RUN apt-get install -y libgtk-3-0 libdbus-glib-1-2 libxt6

COPY firefox /opt/firefox
RUN chmod +x /opt/firefox/firefox

#COPY firefox_60.0.1-5_amd64.deb /
#RUN apt install -y /firefox_60.0.1-5_amd64.deb