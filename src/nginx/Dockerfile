FROM	alpine
	
RUN		apk add nginx openssh openssl && \
		apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
		mkdir -p /run/nginx && \
		echo "root:toor" | chpasswd && \
		ssh-keygen -A && \
		openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 -subj "/C=FR/ST=FRANCE/L=Paris/O=42/CN=172.17.0.3" \
		-keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt 

# Allow ssh conexion (ssh-keygen option -A: for each of the key types for which host keys do not exist,
# generate the host keys witch the default key file path, an empty passphrase, default bits for the key type, and deafault comment).


# Nginx config file and webpage
COPY	/srcs/sshd_config			/etc/ssh/
COPY	/srcs/telegraf.conf			/etc/telegraf/
COPY	/srcs/nginx.conf			/etc/nginx/
COPY	/srcs/ssl_params.conf		/etc/nginx/
COPY	/srcs/index.html			/var/www/
COPY	/srcs/start.sh				/

# We customize the SSH welcome message
RUN		echo 'Welcome to SSH of nginx by sgah' > /etc/motd

EXPOSE	80 443 22

ENTRYPOINT	sh start.sh