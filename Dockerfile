FROM gcc:11 as build
WORKDIR /app

RUN apt-get update && apt-get install -y git \
    && git clone https://github.com/vasylblk/GitFunction.git .

RUN gcc -o http-server server.c -lm

FROM alpine:3.18
WORKDIR /app

RUN apk add --no-cache libstdc++ 

COPY --from=build /app/http-server /app/


CMD ["./http-server"]

