docker-cron-sample
====================

This exemple will help you to create a container with define cron tasks

Dependencies
------------

- [tini](https://github.com/krallin/tini)
- [crond](https://linux.die.net/man/8/crond)

### Why Tini?

Using Tini has several benefits:

- It protects you from software that accidentally creates zombie processes, which can (over time!) starve your entire system for PIDs (and make it unusable).
- It ensures that the default signal handlers work for the software you run in your Docker image. For example, with Tini, SIGTERM properly terminates your process even if you didn't explicitly install a signal handler for it.
- It does so completely transparently! Docker images that work without Tini will work with Tini without any changes.

### Why crond?

`crond` is daemon to execute scheduled commands

```
/ # crond --help
BusyBox v1.26.2 (2017-06-11 06:38:32 GMT) multi-call binary.

Usage: crond -fbS -l N -d N -L LOGFILE -c DIR

        -f      Foreground
        -b      Background (default)
        -S      Log to syslog (default)
        -l N    Set log level. Most verbose:0, default:8
        -d N    Set log level, log to stderr
        -L FILE Log to FILE
        -c DIR  Cron dir. Default:/var/spool/cron/crontabs
```

The very simple `Dockerfile` start `crond` in foreground `-f` and at the log
level `8`

For debug purpose only you can start your container with log level `1` and tail
the container logs `docker logs -f $CONTAINER_ID`

The generated crontab can be find here :

`/var/spool/cron # less crontabs/root`

```
# do daily/weekly/monthly maintenance
# min   hour    day     month   weekday command
*/15    *       *       *       *       run-parts /etc/periodic/15min
0       *       *       *       *       run-parts /etc/periodic/hourly
0       2       *       *       *       run-parts /etc/periodic/daily
0       3       *       *       6       run-parts /etc/periodic/weekly
0       5       1       *       *       run-parts /etc/periodic/monthly
```
