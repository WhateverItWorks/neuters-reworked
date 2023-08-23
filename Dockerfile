#https://hub.docker.com/_/rust
FROM rust:alpine as builder
RUN apk add --no-cache musl-dev
WORKDIR /build 
COPY . .
RUN cargo install --path .
FROM gcr.io/distroless/static
COPY --from=builder /usr/local/cargo/bin/neuters /
CMD ["./neuters", "--address", "0.0.0.0:13369"]
