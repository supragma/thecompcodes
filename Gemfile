# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '6.0.3.1'
# Use postgresql as the database for Active Record
gem 'pg', '0.18'
# Use Puma as the app server
gem 'puma', '4.3.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '1.4.6', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '3.1.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '2.1.0'
  gem 'spring-watcher-listen', '2.0.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '1.2.7', platforms: %i[mingw mswin x64_mingw jruby]

# For code coverage report
gem 'codecov', '0.1.16', require: false, group: :test
gem 'simplecov', '0.18.5', require: false, group: :test

# For code styling
gem 'rubocop', '0.85.0', require: false

gem "activesupport", "6.0.3.1"
gem "actionview", "6.0.3.1"
gem "actionpack", "6.0.3.1"
