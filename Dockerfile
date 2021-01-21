FROM ruby:3.0.0-alpine3.12

LABEL maintainer="Joel Azemar joel.azemar@gmail.com"

RUN apk add --no-cache \
  # Bundler needs it to install forks and github sources.
  git \
  # Gems need the dev-headers/compilers.
  build-base \
  # Gem Exif need the lib Exif
  libexif-dev

ENV BUNDLER_VERSION 2.2.3
ENV BUNDLE_JOBS 20
ENV BUNDLE_RETRY 5
ENV BUNDLE_CACHE_ALL true

WORKDIR /workdir

RUN gem install bundler -v $BUNDLER_VERSION

COPY ./ ./

RUN bundle install