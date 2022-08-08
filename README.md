# EmailRelay
E-MailRelay application on a Docker container, with docker images hosted on https://hub.docker.com/repository/docker/nicozanf/emailrelay .

## Attributions

This is mainly taken from https://github.com/NMichas/EmailRelay but updated to the latest source programs and Alpine version. Now it can lso run on RaspberryPi, due to
cross-compiling made on Ubuntu with a command like: 

```
docker buildx build -t  nicozanf/emailrelay:2.3-0 --platform linux/amd64,linux/arm64,linux/arm/v7 --push .
```

where 2.3 is the EmailRelay source version on https://sourceforge.net/p/emailrelay/wiki/Home/  and the -0 is my build version tag.


## Docker image usage example

This example is for use as an SMTP proxy on LibreElec on Rpi3 (I have an old appliance that can only use port 25/TCP, and its use has recently been denied
by my ISP). But you can easily adapt it to your needs, by changing the configuration files and also the listening TCP port if needed.

1. Create a folder on the host for persistent data - for example on LibreElec use `/storage/.config/dockers/emailrelay/config`. On a full Linux OS, it's better to use
   something like `/opt/appdata/emailrelay/config`.
2. on that folder create two configuration files `emailrelay.conf`  and `emailrelay.auth` (simply use the example files attached in this repository but adapt them
   for your needs)
3. run the following commands for downloading the image from DockerHub and running the container:

```
docker run -d \
--name=emailrelay \
-e PUID=0 \
-e PGID=0 \
-p 25:25 \
-v /storage/.config/dockers/emailrelay/config:/config \
--restart unless-stopped \
nicozanf/emailrelay \
/usr/sbin/emailrelay /config/emailrelay.conf
```

where `/storage/.config/dockers/emailrelay/config` is the folder created on point 1. 

If you should find any problem, turn on the debug logs by editing `emailrelay.conf`.

Also, you might consider generating some sort of alert if there are bad messages in the spool directory. In the old days you would have a one-line cron job doing "ls
/var/spool/emailrelay/*.bad >&2 2>/dev/null"; if there are any bad files they get listed to stderr and cron will send a system email to 'root' containing any stderr output (this is a suggestion from Graeme Walker).
