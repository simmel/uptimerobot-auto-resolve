# UptimeRobot auto resolver

I've had too many network issues where I host things which means that I get
email storms from UptimeRobot that all services are "DOWN" and later "UP".

I've been eyeing [imapfilter](https://github.com/lefcha/imapfilter/) 🌛❤️ for a
while but never got around doing anything about it, until now.

So the idea is to:
* Monitor a mailbox
* When we get `Monitor is UP` mails
* Remove that and the corresponding `Monitor is DOWN` mail
