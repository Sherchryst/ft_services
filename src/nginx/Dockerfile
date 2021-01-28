FROM alpine

LABEL sgah <sgah@student.42.fr>

#INSTALL PKG
RUN apk update
RUN apk add openrc --no-cache
RUN apk add openssh
RUN apk add openssl
RUN apk add nginx
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# CREATE WEB SERVER
RUN adduser -D -g 'www' www

# SETUP SERVER & PERMISSION
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
RUN mkdir -p /run/nginx

# COPY CONF & HTLM PAGE
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /www/index.html

# CREATE SSH USER & SSL KEY
RUN adduser -D user
RUN echo "user:password"|chpasswd
RUN ssh-keygen -A
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

# TSETUP TELEGRAF
RUN mkdir -p /etc/telegraf
COPY telegraf.conf /etc/telegraf/telegraf.conf

# CUSTOM MESSAGE
RUN echo 'SSH of ft_services by Sgah' > /etc/motd

# COMMANDE
COPY start.sh ./start.sh
RUN chmod +x /start.sh
CMD sh ./start.sh
EXPOSE 80
EXPOSE 443
EXPOSE 22