# Dockerfile
FROM ruby:3.0.2

ENV BUNDLE_VERSION 2.2.30
ENV APP_HOME /app
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000
ENV RAILS_SERVE_STATIC_FILES=true

# Add yarn from repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install required package
RUN apt-get update -qq \
&& apt-get install -y \
build-essential \
apt-utils \
nodejs \
yarn \
nano


RUN mkdir $APP_HOME
WORKDIR $APP_HOME


# Copy created Gemfile & Gemfile.lock to docker container
COPY Gemfile /$APP_HOME/Gemfile
COPY Gemfile.lock /$APP_HOME/Gemfile.lock

# Install dependencies
RUN gem install bundler --version "$BUNDLE_VERSION"
RUN bundle install --without development test
COPY . /$APP_HOME

RUN yarn install --check-files
RUN RAILS_ENV=production bundle exec rake assets:precompile
EXPOSE $RAILS_PORT


# CMD ["sleep", "99d"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-e", "production"]