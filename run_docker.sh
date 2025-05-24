#!/usr/bin/env sh

spawn-fcgi -p 9000  -- /srv/server.pl
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
