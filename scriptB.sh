#!/bin/bash

SERVER_URL="http://localhost"

while true; do
    sleep $((RANDOM % 6 + 5)) 
    curl -s "$SERVER_URL" &
done
