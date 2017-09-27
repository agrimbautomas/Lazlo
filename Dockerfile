FROM ruby:2.4.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /usr/src/alomacain
WORKDIR /alomacain
ADD Gemfile /alomacain/Gemfile
ADD Gemfile.lock /alomacain/Gemfile.lock
RUN bundle install
ADD . /alomacain