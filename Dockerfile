# syntax = docker/dockerfile:1

# ----------------------------------------------------------------------------------------------------------------------------
# Base image

ARG RUBY_VERSION=3.3.5
FROM registry.docker.com/library/ruby:$RUBY_VERSION AS base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    pkg-config \
    libpq-dev \
    libz-dev \
    dh-autoreconf \
    libexpat1-dev \
    libglib2.0-dev \
    libvips-dev \
    libvips \
    libvips-tools \
    curl \
    postgresql-client \
    neovim \
    xz-utils && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install the latest stable LTS version of Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# Install jemalloc
RUN git clone https://github.com/jemalloc/jemalloc.git && \
    cd jemalloc && \
    git checkout 5.2.1 && \
    autoconf && \
    ./configure && \
    make && \
    make install

RUN mkdir data
WORKDIR /rails

ENV BUNDLE_PATH="/usr/local/bundle"
ENV LD_PRELOAD=/usr/local/lib/libjemalloc.so.2

COPY . .
RUN bundle config set --local frozen false && \
    bundle install && \
    rm -rf ~/.bundle/ \
    "${BUNDLE_PATH}"/ruby/*/cache \
    "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

ENTRYPOINT ["/rails/bin/docker-entrypoint"]
RUN touch /root/.bash_history && chmod +x /root/.bash_history
RUN touch /root/.irb_history && chmod +x /root/.irb_history

RUN echo 'export HISTFILE=/root/.bash_history' >> /root/.bashrc

EXPOSE 3000
CMD rm -f /rails/tmp/pids/server.pid && ./bin/rails server -b 0.0.0.0
