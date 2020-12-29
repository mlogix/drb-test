FROM ruby:3.0.0

RUN mkdir /app
WORKDIR /app

RUN gem install bundler

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install --jobs 20

ADD . /app

EXPOSE 8787

CMD ruby /app/server.rb