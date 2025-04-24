# Must match the versions found in .ruby-version and the Gemfile.
ARG RUBY_VERSION=3.4.3

# Start with a basic ruby base image.
FROM ruby:$RUBY_VERSION-slim

LABEL author="joelgrantdev@gmail.com"

# Set a directory inside the container where the app should live.
WORKDIR /myapp

# Move the source code to the chosen working directory
COPY . .

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config


COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]