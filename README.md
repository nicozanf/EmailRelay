# EmailRelay
E-MailRelay application on a Docker container

This is mainly taken from https://github.com/NMichas/EmailRelay but updated and hopefully working with Raspberry, too.

The cross-compiling was made on Ubuntu with a command like: 

'docker buildx build -t  nicozanf/emailrelay:2.3-0 --platform linux/amd64,linux/arm64,linux/arm/v7 --push . '

where 2.3 is the EmailRelay source version on https://sourceforge.net/p/emailrelay/wiki/Home/  and the -0 is my build version tag.
