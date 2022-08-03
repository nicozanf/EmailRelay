# EmailRelay
E-MailRelay application on a Docker container

This is mainly taken from https://github.com/NMichas/EmailRelay but updated and hopefully working with RaspberryPi, too.

The cross-compiling was made on Ubuntu with a command like: 

'docker buildx build -t  nicozanf/emailrelay:2.3-0 --platform linux/amd64,linux/arm64,linux/arm/v7 --push . '

where 2.3 is the EmailRelay source version on https://sourceforge.net/p/emailrelay/wiki/Home/  and the -0 is my build version tag.


## Docker image usage

1. Create a folder on the host for persistent data - for example on LibreElec on Rpi use `/storage/.config/dockers/emailrelay/config`.
2. on that folder create two configuration files `emailrelay.conf`  and `emailrelay.auth` (use the files in this repository and adapt them
   for your needs)
3. run the following commands for downloading the image from DockerHub and running  the container:

```
docker run -d \
--name=emailrelay \
-e PUID=0 \
-e PGID=0 \
-e TZ=Europe/Paris \
-p 25:25 \
-v /storage/.config/dockers/emailrelay/config:/config \
--restart unless-stopped \
nicozanf/emailrelay \
emailrelay /config/emailrelay.conf 
```

where `/storage/.config/dockers/emailrelay/config` is the folder created on point 1
