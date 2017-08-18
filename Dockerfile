# Base our image on an official, minimal image of our preferred Ruby
FROM ruby:2.3.0

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN apt-get install -y nodejs
# RUN apt-get install -y mysql-client

# Define where our application will live inside the image
ENV RAILS_ROOT /var/www/railsapps/blog

# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $RAILS_ROOT/tmp/pids

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
# (the src likely changed and we don't want to invalidate Docker's cache too early)
# http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock
COPY ./vendor ./vendor

# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
RUN gem install bundler

# Install gems
RUN bundle install

# Copy the Rails application into place
# Optimizing to improve build time
COPY ./app ./app
COPY ./bin ./bin
COPY ./config ./config
COPY ./db ./db
# COPY ./docker ./docker
COPY ./lib ./lib
COPY ./log ./log
COPY ./public ./public
# COPY ./scripts ./scripts
# COPY ./questions ./questions
COPY config.ru config.ru
COPY Dockerfile Dockerfile
COPY Rakefile Rakefile
COPY start.sh start.sh
# COPY wait_for_it.sh wait_for_it.sh

# Define the script we want run once the container boots
# Use the "exec" form of CMD so our script shuts down gracefully on SIGTERM (i.e. `docker stop`)

# App start
# RUN chmod +x docker/load_quiz.sh
RUN chmod +x start.sh

EXPOSE 3000

CMD ["./start.sh"]


