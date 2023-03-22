#!/bin/sh
bundle exec rails db:seed RAILS_ENV=production
bundle exec sidekiq -C config/sidekiq.yml RAILS_ENV=productiondslkq;dq
