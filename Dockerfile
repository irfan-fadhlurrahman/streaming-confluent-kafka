FROM python:3.9

# General Packages
RUN apt-get -y update

# Python Virtual Environment
COPY requirements.txt .
RUN python3 -m venv /opt/venv

ENV PATH "/opt/venv/bin:$PATH"

RUN /opt/venv/bin/pip install -U pip
RUN /opt/venv/bin/pip install -r requirements.txt

RUN which python

EXPOSE 9092
EXPOSE 29092

ENTRYPOINT [ "bash" ]