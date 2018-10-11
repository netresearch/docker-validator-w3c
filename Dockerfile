FROM debian:stable-slim

LABEL maintainer.1="Norman Bestfleisch <norman.bestfleisch@netresearch.de>" \
      maintainer.2="Sebastian Mendel <sebastian.mendel@netresearch.de>"

# dash.preinst: cannot remove /usr/share/man/man1/sh.distrib.1.gz: No such file or directory

RUN mkdir -p /usr/share/man/man1/ && touch /usr/share/man/man1/sh.distrib.1.gz \
 && apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install \
    apache2 \
    w3c-markup-validator \
    --no-install-recommends \
 && apt-get autoremove -y \
 && apt-get clean -y \
 && rm -rf /tmp/* \
 && rm -rf /var/tmp/* \
 && for logs in `find /var/log -type f`; do > $logs; done \
 && rm -rf /usr/share/locale/* \
 && rm -rf /usr/share/man/* \
 && rm -rf /usr/share/doc/* \
 && rm -rf /var/lib/apt/lists/* \
 && rm -f /var/cache/apt/*.bin

ADD setup/ /
RUN chmod u+x /*.sh \
 && /configure.sh \
 && ln -sf /dev/stdout /var/log/apache2/access.log \
 && ln -sf /dev/stdout /var/log/apache2/other_vhosts_access.log \
 && ln -sf /dev/stderr /var/log/apache2/error.log

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
