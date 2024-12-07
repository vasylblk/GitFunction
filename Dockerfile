FROM gcc:11 AS build

WORKDIR /app

RUN apt-get update && apt-get install -y make
COPY . .
RUN git clone https://github.com/vasylblk/GitFunction.git .


FROM alpine:3.18

WORKDIR /app
RUN make
WORKDIR /app
COPY --from=build /app/http-server /app/
RUN ls -l /app/http-server

CMD ["/app/http-server"]

