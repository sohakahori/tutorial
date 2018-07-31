FROM ruby:2.4.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /tutorial
WORKDIR /tutorial
ADD Gemfile /tutorial/Gemfile
ADD Gemfile.lock /tutorial/Gemfile.lock
RUN bundle install
ADD . /tutorial
