FROM ruby:2.6.3
ENV LANG C.UTF-8

ENV APP_ROOT /workspace
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn


ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
ADD ./yarn.lock yarn.lock

#install bundler
ENV BUNDLER_VERSION 2.1.4
RUN gem update --system \
    && gem install bundler -v $BUNDLER_VERSION \
    && bundle install

RUN yarn install --check-files
RUN yarn check --integrity

COPY . $APP_ROOT
EXPOSE 3000
