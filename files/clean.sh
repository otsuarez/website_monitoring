#!/bin/bash
for i in `docker ps -a | egrep -v CONTAINER | awk '{print $1}'` ; do docker rm $i ; done
for i in `docker volume ls | egrep -v DRIVER | awk '{print $2}'` ; do docker volume rm $i ; done

