FROM python:3.9-bullseye

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y ffmpeg wget unzip zip

COPY . ./
RUN chmod +x ./start.sh

RUN python -m pip install -r requirements.txt

RUN wget https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip && \
    unzip vosk-model-small-en-us-0.15.zip && \
    mv vosk-model-small-en-us-0.15 model

ENV PATH /usr/bin/:$PATH
ENTRYPOINT ["/bin/bash", "-l", "-c"]
CMD ["./start.sh"]
