FROM python:3.8-alpine
ENV PATH="scripts:${PATH}"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN pip install -r /requirements.txt
RUN apk del .tmp

RUN mkdir /app 
WORKDIR /app 
COPY ./app /app 
COPY ./scripts /scripts

RUN chmod +* /scripts/*

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/

RUN adduser -D user
RUN chown -R user:user /vol
RUN chmod -R 755 /vol/web
USER user 

CMD ["entrypoint.sh"]