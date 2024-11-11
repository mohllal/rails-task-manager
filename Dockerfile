# Use the official Ruby image from the Docker Hub
FROM ruby:3.2.5

# Install dependencies
RUN apt-get update -qq \
  && apt-get install -y nodejs default-libmysqlclient-dev \
  && rm -rf /var/lib/apt/lists/*

# Set an environment variable to avoid installing gem documentation
ENV BUNDLE_PATH /gems

# Create and set the working directory
RUN mkdir /src
WORKDIR /src

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /src/Gemfile
COPY Gemfile.lock /src/Gemfile.lock

# Install the gems
RUN bundle config set force_ruby_platform true \
  && bundle install

# Copy the rest of the application code
COPY . /src

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3000 to the Docker host
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]
