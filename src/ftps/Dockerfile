FROM	alpine

RUN		apk update && apk add vsftpd openssl && \
		apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
		echo "root:toor" | chpasswd && \
		openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 -subj "/C=FR/ST=France/L=Paris/O=42/CN=172.17.0.3" \
		-keyout /etc/ssl/private/vsftpd.key \
		-out /etc/ssl/certs/vsftpd.crt

COPY	/srcs/telegraf.conf			/etc/telegraf/
COPY	/srcs/vsftpd.conf			/etc/vsftpd
COPY	/srcs/start.sh				/

#Port 21 works in active and passive mode. Port 30021 only passive mode works.
EXPOSE	21 30021

ENTRYPOINT	sh start.sh