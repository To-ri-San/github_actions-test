# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.2.1"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"

# Use Puma as the app server
gem "puma", "~> 3.11"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
gem "mini_magick", "~> 4.8"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors", "~> 1.0.3"

gem "devise_token_auth", "~> 1.1.0"
gem "active_model_serializers", "~> 0.10.9"
gem "aws-sdk", "~> 3.0.1"

# QR code
gem "rqrcode", "~> 0.10.1"
gem "rqrcode_png", "~> 0.1.5"
gem "chunky_png", "~> 1.3.11"

gem "geocoder", "~> 1.5.1"

# bulkInsert
gem "activerecord-import", "~> 1.0.1"

# sidekiq
gem "sidekiq", "~> 5.2.7"
gem "sidekiq-scheduler", "~> 3.0.0"

# detect User Agent
gem "rack-user_agent", "~> 0.5.2"

# dotenv
gem "dotenv-rails", "~> 2.7.5"

# google drive
gem "google-api-client", "~> 0.32.1"

# contentful
gem "contentful", "~> 2.13.3"

# i18n
gem "rails-i18n", "~> 5.1.3"

# passbook
gem "passbook"

# slack
gem "slack-notifier", "~> 2.3.2"

# payjp
gem "payjp"

# twilio
gem "twilio-ruby"

# autodoc
gem "autodoc"

# firebase_dynamic_link
gem "firebase_dynamic_link"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 3.8"
  gem "factory_bot_rails", "~> 5.1.1"
  gem "rubocop", "~> 0.77.0"
  gem "rubocop-performance", "~> 1.5.1"
  gem "rubocop-rails", "~> 2.4.0"
  # gem "bullet"
  # gem "parallel_tests"
end

group :staging, :production do
  gem "newrelic_rpm"
end

group :development do
  gem "rb-readline", "~> 0.5.5"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  # letter_opener
  gem "letter_opener", "~> 1.7.0"
  gem "pre-commit", require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data"