# phusion-baseimage-logging

Recreate problem I'm having with phusion/baseimage logging.

Contents of testecho.sh:

```
#!/bin/bash

while true
do
        echo "hello to stdout"
        logger "hello to syslog"
    sleep 5
done
```

Now build image and run container:

```
MYDIR=/tmp/logging
git clone git@github.com:stevecaldwell77/phusion-baseimage-logging.git $MYDIR
cd $MYDIR
docker build -t phusion-baseimage-logging .
CID=$(docker run -d phusion-baseimage-logging)
```

Tail logs:

```
docker logs -f $CID
```

I see "hello to stdout" scroll by, but not "hello to syslog".

If I connect to the container and try tailing syslog manually:

```
docker exec -ti $CID bash -l
tail -f /var/log/syslog
```

It will output the last 10 lines, including "hello to syslog" messages, but it will not "follow" the file, staying stopped at the last line at the time tail was executed.  If I run "tail -f" again, I get newer lines, but again no following.
