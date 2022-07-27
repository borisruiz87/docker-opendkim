FROM alpine:latest
RUN apk --no-cache add bash opendkim opendkim-utils busybox-extras && rm -rf /var/cache/apk/*

# Add configs
ADD ./etc/ /etc/

# dando permisos al directorio de dkim
RUN chown -R opendkim:opendkim /etc/opendkim/keys/

# creando el directorio
RUN mkdir /run/opendkim && chown -R opendkim:opendkim /run/opendkim/

# asignando un usuario postfix y adicionandole al grupo opendkim
RUN adduser -H -D -s /sbin/nologin postfix && addgroup postfix opendkim

# Define mountable directories.
# VOLUME ["/etc/opendkim"]

# Define default command.
 CMD ["/usr/sbin/opendkim", "-f",  "-l",  "-x",  "/etc/opendkim/opendkim.conf"]

# Expose ports.
EXPOSE 8891
