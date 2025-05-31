FROM ruby:3.1

# Install OS dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

# Set working directory
WORKDIR /app

# Copy Gemfile and install gems
COPY Gemfile ./
RUN gem install bundler && bundle install

# Copy the full app
COPY . .

# Precompile assets if needed
# RUN bundle exec rake assets:precompile

# Expose port
EXPOSE 3000

# Run the server (overridden by docker-compose)
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
