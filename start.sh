#!/bin/bash
RAILS_ENV=development bundle exec rake db:migrate || true && \
bundle exec rake assets:precompile RAILS_ENV=development || true && \
RAILS_ENV=development bundle exec rails s -p 3000 -b '0.0.0.0'