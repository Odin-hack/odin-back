FROM ruby:3.1

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs yarn cron

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . .

RUN whenever --update-crontab

CMD cron && rails s -b 0.0.0.0 -p 3000
