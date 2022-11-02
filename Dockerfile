FROM alpine:latest
RUN apk --no-cache add bash opendkim opendkim-utils busybox-extras rsyslog tzdata supervisor && rm -rf /var/cache/apk/*

# Add configs
ADD ./etc/ /etc/

# dando permisos al directorio de dkim
RUN chown -R opendkim:opendkim /etc/opendkim/keys/ && chmod -R 0750 /etc/opendkim/keys/ && chmod 0400 /etc/opendkim/keys/othar.cu/* && chmod 0400 /etc/opendkim/keys/fuegoenterprises.cu/*

# creando el directorio
RUN mkdir /run/opendkim && chown -R opendkim:opendkim /run/opendkim/

# asignando un usuario postfix y adicionandole al grupo opendkim
#RUN adduser -H -D -s /sbin/nologin postfix && addgroup postfix opendkim

# incorporando la zona horaria de Cuba
RUN  cp /usr/share/zoneinfo/Cuba /etc/localtime

# Define mountable directories.
VOLUME ["/var/log"]
# Expose ports.
EXPOSE 8891

# levantando el supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["sh","-c","/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf"]
