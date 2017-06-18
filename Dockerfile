FROM ubuntu

RUN apt-get update
RUN apt-get install -y tor \
                       privoxy \
                       vim-tiny \
                       python \
                       python-virtualenv

COPY torrc /etc/tor/torrc
COPY privoxy.config /etc/privoxy/config

RUN virtualenv -p python2.7 /virtualenv

COPY requirements.txt /src/requirements.txt
RUN /virtualenv/bin/pip install -r /src/requirements.txt

COPY pyStem.py /src/pyStem.py

CMD /etc/init.d/tor start && \
    /etc/init.d/privoxy start && \
    /virtualenv/bin/python /src/pyStem.py
