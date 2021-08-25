FROM ruby:2.7-alpine3.14

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

ENV BUILD_PACKAGES curl-dev build-base

RUN apk update && \
    apk upgrade && \
    apk add git curl bash $BUILD_PACKAGES

WORKDIR /usr/src/app

COPY . .

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    source $HOME/.cargo/env && \
    export RUSTFLAGS='-C target-feature=-crt-static'

ENV RUSTFLAGS='-C target-feature=-crt-static'
ENV PATH=/root/.cargo/bin:$PATH

RUN gem update bundler && \
    bundle install && \
    rake install:local

ENTRYPOINT ["./run.sh"]

