FROM oldwebtoday/base-browser

USER root

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -qqy \
    git \
    libsdl2-dev \
    libpng-dev \
    cmake \
    portaudio19-dev \
    libreadline-dev \
    p7zip \
    python-pip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/browser

USER browser

RUN pip install bottle requests

RUN git clone https://github.com/probonopd/previous
RUN cd previous && cmake . && make

ADD NS33.tar.gz /home/browser/

COPY tars.iso.dmg /home/browser/

COPY previous.cfg /home/browser/.previous/previous.cfg

COPY proxy.py /home/browser/proxy.py

COPY run.sh /app/run.sh

LABEL wr.name="WWW" \
      wr.os="NextSTEP" \
      wr.about="https://en.wikipedia.org/wiki/WorldWideWeb"
 
