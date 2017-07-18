#!/bin/bash

build:

			docker build -t ispa_base:latest -f Dockerfile.base .
			docker build -t ispa:latest -f Dockerfile.prod .
			docker build -t ispa:latest-local Dockerfile.local .
			docker build -t ispa:latest-test Dockerfile.unittest .
			docker-compose -f docker-compose.local.yml build

start_services:

			docker-compose -f common-services up

run_local:

			docker run -it --rm -d --workdir=/home/docker/ \
			--volume $(pwd)/config:/home/docker/config \
			--volume $(pwd)/ispa:/home/docker/src \
			--volume $(pwd)/requirements:/home/docker/requirements \
			--name ispa --publish 8000:8000 \
			ispa:latest-local ./manage.py runserver 0.0.0.0:8000

run_celery:

			docker run -it --rm -d --workdir=/home/docker/ \
			--volume $(pwd)/config:/home/docker/config \
			--volume $(pwd)/ispa:/home/docker/src \
			--volume $(pwd)/requirements:/home/docker/requirements \
			--name ispa --publish 8000:8000 \
			ispa /bin/bash ./run_celery.sh
