FROM debian:buster-slim

RUN apt-get -qq update && apt-get -qq install \
      imapfilter \
      # FIXME Remove lua dep? It's only ~800kB and useful for debugging
      lua5.2 \
      && rm -rf /var/lib/apt/lists/*

ENV HOME=/srv

USER 1000

ENTRYPOINT ["imapfilter"]
