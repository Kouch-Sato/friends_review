FROM ruby:2.5.3-alpine as base

ENV LANG C.UTF-8

ENV APP_HOME /var/www/friends_review

ENV BUNDLE_APP_CONFIG=${APP_HOME}/.bundle \
    BUNDLE_JOBS=10 \
    BUNDLE_PATH=/bundle

# Set application home directory
RUN mkdir -p $APP_HOME

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache \
      build-base \
      git \
      less \
      mariadb-embedded-dev \
      mariadb-connector-c-dev \
      ruby-json \
      ruby-dev \
      tzdata \
      yaml-dev \
      zlib-dev \
      nodejs

# Set working directory
WORKDIR $APP_HOME

COPY . ./

RUN bundle install