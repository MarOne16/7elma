# base image
FROM    debian:bullseye

# install nginx and openssl keys and certificates
RUN     apt update && apt install nginx openssl -y 

RUN    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out /etc/ssl/certs/nginx-selfsigned.crt \
        -subj "/C=MO/ST=KHOURIBGA/L=KHOURIBGA/O=1337/OU=student/CN=localhost"
COPY    ./nginx.conf /etc/nginx/conf.d/

# running the nginx in daemon mode
CMD     ["nginx", "-g", "daemon off;"];

