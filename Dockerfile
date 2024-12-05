FROM gcc:11 AS build

WORKDIR /app

RUN git clone https://github.com/vasylblk/GitFunction.git .
RUN make

FROM alpine:3.18

WORKDIR /app

COPY --from=build /app/http-server /app/

CMD ["/app/http-server"]

