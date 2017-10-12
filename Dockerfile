FROM ruby:2.4.2
WORKDIR /usr/src/alomacain
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
ADD Gemfile /usr/src/alomacain/Gemfile
ADD Gemfile.lock /usr/src/alomacain/Gemfile.lock
RUN bundle install
COPY . /usr/src/alomacain
EXPOSE 3000
CMD [ "bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0" ]
