FROM ruby:2.5.1
WORKDIR /usr/src/lazlo
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
ADD Gemfile /usr/src/lazlo/Gemfile
#ADD Gemfile.lock /usr/src/lazlo/Gemfile.lock
RUN bundle install
COPY . /usr/src/lazlo
EXPOSE 3000
CMD [ "bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0" ]
