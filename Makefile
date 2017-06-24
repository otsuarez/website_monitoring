all: help

help:
	@echo 
	@echo " Usage:"
	@echo "	make conf 	# setup conf - for alertmanager"
	@echo "	make up 	# docker-compose up"
	@echo 

beeping:
	files/update_beeping_env.sh

grafana:
	sleep 10 && cd files && ./provision-grafana.sh

conf:
	files/setup_conf.sh

up:
	docker-compose up  -d
	
stop:
	docker-compose stop -t 0

init: beeping up conf grafana rsall

clean:
	files/clean.sh

sh:
	docker run -it --rm -v websitemonitoring_etc_data:/etc/prometheus  busybox ash

rl: reload
reload:
	curl -X POST http://localhost:9090/-/reload

prom-restart:
	docker stop websitemonitoring_prometheus_1
	docker start websitemonitoring_prometheus_1

alert-restart:
	docker stop websitemonitoring_alertmanager_1 
	docker start websitemonitoring_alertmanager_1

alert: conf rl alert-restart

r: alert-reload prom-reload
alert-reload:
	curl -XPOST http://localhost:9093/-/reload
prom-reload:
	curl -XPOST http://localhost:9090/-/reload

rsall: prom-restart alert-restart

logs:
	docker-compose logs -f
