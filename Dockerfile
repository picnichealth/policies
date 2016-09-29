FROM ruby:2.3.3-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y -q --no-install-recommends \
  build-essential

RUN mkdir -p /policies
WORKDIR /policies

COPY Gemfile . 
COPY Gemfile.lock .

RUN bundle install

RUN apt-get install -y nodejs

COPY . .

RUN rake build

CMD rake serve_static