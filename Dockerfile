FROM netcapsule/base-browser

ENV FF_VERSION 40.0.3

RUN apt-get update && apt-get install -y \
    libgtk2.0-0 libasound2 libdbus-glib-1-2 libnss3-tools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /download

RUN wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FF_VERSION/linux-x86_64/en-US/firefox-$FF_VERSION.tar.bz2 && \
    tar xvf firefox-$FF_VERSION.tar.bz2
RUN sudo mv ./firefox /opt/firefox

USER browser

#WORKDIR /home/browser/ffprofile

COPY ./ffprofile/. /home/browser/ffprofile/

COPY flux-apps /home/browser/.fluxbox/apps
RUN sudo chown browser:browser -R /home/browser/.fluxbox

COPY run.sh /app/run.sh

RUN sudo chmod a+x /app/run.sh

CMD /app/entry_point.sh /app/run.sh


