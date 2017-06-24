#/bin/bash
set -e

docker run -v websitemonitoring_etc_data:/data --name helper busybox true
# docker cp files/alertmanager.yml helper:/data
# docker cp files/prometheus.yml helper:/data
# docker cp files/target_nodes.json helper:/data
for i in `ls files/prometheus/*`
do
  docker cp $i helper:/data
done
   
docker rm helper
