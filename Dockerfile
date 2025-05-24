FROM caddy:latest

COPY Caddyfile /etc/caddy/Caddyfile
COPY /static /srv/static
COPY run_docker.sh server.pl cpanfile /srv/

RUN apk update
RUN apk add gcc libc-dev make tzdata perl perl-dev perl-app-cpanminus spawn-fcgi
RUN cpanm --installdeps .
RUN chmod a+x run_docker.sh

EXPOSE 8080
CMD ["./run_docker.sh"]

