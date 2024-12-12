#!/bin/bash

monitor_cpu_usage() {
    local container=$1
    local core=$2

    usage=$(docker stats --no-stream --format "{{.CPUPerc}}" "$container" | tr -d '%')
    usage=${usage%.*}
    echo "$usage"
}


docker run -d --name srv1 --cpuset-cpus=0 vasylbulak/http-server:latest

while true; do
    sleep 120 

    if docker ps | grep -q srv1; then
        usage=$(monitor_cpu_usage srv1 0)
        if [ "$usage" -ge 80 ]; then
            if ! docker ps | grep -q srv2; then
                docker run -d --name srv2 --cpuset-cpus=1 vasylbulak/http-server:latest
            fi
        fi
    fi
    
    if docker ps | grep -q srv2; then
        usage=$(monitor_cpu_usage srv2 1)
        if [ "$usage" -ge 80 ]; then
            if ! docker ps | grep -q srv3; then
                docker run -d --name srv3 --cpuset-cpus=2 vasylbulak/http-server:latest
            fi
        elif [ "$usage" -lt 10 ]; then
            docker stop srv2 && docker rm srv2
        fi
    fi

    if docker ps | grep -q srv3; then
        usage=$(monitor_cpu_usage srv3 2)
        if [ "$usage" -lt 10 ]; then
            docker stop srv3 && docker rm srv3
        fi
    fi

    docker pull vasylbulak/http-server:latest
    if docker inspect --format '{{.Id}}' srv1 | grep -v "$(docker inspect --format '{{.Id}}' vasylbulak/http-server:latest)"; then
        docker stop srv1 srv2 srv3
        docker run -d --name srv1 --cpuset-cpus=0 vasylbulak/http-server:latest
        docker run -d --name srv2 --cpuset-cpus=1 vasylbulak/http-server:latest
        docker run -d --name srv3 --cpuset-cpus=2 vasylbulak/http-server:latest
    fi

# Function to stop and remove container if it exists
remove_container_if_exists() {
    if [ "$(docker ps -aq -f name=$1)" ]; then
        echo "Stopping and removing $1..."
        docker stop $1
        docker rm $1
    fi
}

remove_container_if_exists srv1
docker run --name srv1 --cpuset-cpus="0" -d vasylbulak/http-server:latest
echo "srv1 launched on CPU core #0"

remove_container_if_exists srv2
docker run --name srv2 --cpuset-cpus="1" -d vasylbulak/http-server:latest
echo "srv2 launched on CPU core #1"

remove_container_if_exists srv3
docker run --name srv3 --cpuset-cpus="2" -d vasylbulak/http-server:latest
echo "srv3 launched on CPU core #2"

done
