# Vanilla IMAP baby 🍦🧊🧊👶

> And if there was a problem, yo, I'll solve it
>
> — Vanilla Ice

I've had too many network issues where I host things which means that I get
email storms from e.g. UptimeRobot that all services are "DOWN" and later "UP".

I've been eyeing [imapfilter](https://github.com/lefcha/imapfilter/) 🌛❤️ for a
while but never got around doing anything about it, until now.

So the idea is to:
* Monitor a mailbox
* When we get `Monitor is UP` mails
* Remove that and the corresponding `Monitor is DOWN` mail

### Supports

* [UptimeRobot](https://uptimerobot.com)
* [Healthchecks.io](https://healthchecks.io)
* [Uptime Kuma](https://github.com/louislam/uptime-kuma)

## Usage

```console
$ cat > .env <<EOF
SERVER=imap.domain.tld
USERNAME=username
PASSWORD=password
EOF
$ docker compose run --rm vanilla-imap-baby
```
