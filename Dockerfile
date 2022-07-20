FROM alpine:latest
RUN apk --no-cache add bash opendkim opendkim-utils && rm -rf /var/cache/apk/*

# Add configs
ADD ./etc/ /etc/

# dando permisos al directorio de dkim
RUN chown -R opendkim:opendkim /etc/opendkim/keys/

# Define mountable directories.
VOLUME ["/etc/opendkim"]

# Define default command.
CMD ["/usr/sbin/opendkim", "-f",  "-l",  "-x",  "/etc/opendkim/opendkim.conf"]

# Expose ports.
EXPOSE 8891
