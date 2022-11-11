FROM debian:buster-slim

RUN apt-get -qq update && apt-get -qq install \
      imapfilter \
      # FIXME Remove lua dep? It's only ~800kB and useful for debugging
      lua-socket \
      lua5.2 \
      rlfe \
      wget \
      && chown -R 1000:1000 /srv \
      && rm -rf /var/lib/apt/lists/*

ENV HOME=/srv

USER 1000

COPY ./imapfilter.lua /srv/.imapfilter/config.lua

# https://github.com/moby/moby/issues/25450
# https://github.com/moby/moby/issues/28009
ENTRYPOINT sleep 0.1 && exec rlfe imapfilter "$0" "$@"
