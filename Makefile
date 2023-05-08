SHELL := /bin/bash

include .env

# General
create-common-files:
	touch .env .gitignore Makefile README.md LICENSE.md requirements.txt

# Docker
create-docker-network:
	docker network create kafka-network

docker-spin-up:
	docker compose --env-file=.env up -d zookeeper
	docker compose --env-file=.env up -d broker

docker-spin-down:
	docker compose down --remove-orphans

# Confluent Kafka
create-topic:
	docker compose exec broker \
		kafka-topics --create \
		--topic purchases \
		--bootstrap-server localhost:9092 \
		--replication-factor 1 \
		--partitions 1

run-producer:
	chmod u+x ./src/producer.py
	docker compose run job ./src/producer.py getting_started.ini 

run-consumer:
	chmod u+x ./src/consumer.py
	docker compose run job ./src/consumer.py getting_started.ini