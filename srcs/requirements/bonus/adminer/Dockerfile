FROM debian:bullseye

RUN apt update -y ; apt install wget php php-mysql  -y

COPY ./tools/script.sh /

ENTRYPOINT [ "bash", "script.sh"]