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

gem 'actionpack', '6.0.3.1'
gem 'actionview', '6.0.3.1'
gem 'activesupport', '6.0.3.1'

group :development, :test do
  gem 'database_cleaner', '1.8.5'
  gem 'factory_bot_rails', '6.0.0'
  gem 'faker', '2.12.0'
  gem 'knock'
  gem 'rspec-rails', '3.9.1'
  gem 'rswag', '2.3.1'
  gem 'shoulda-matchers', '4.3.0'
  gem 'webmock', '3.7'
end

gem 'pundit', '2.1'

gem 'devise', '4.7.2'
gem 'jwt', '1.5.6'
gem 'simple_command', '0.1.0'

gem 'active_model_serializers', '0.10.10'
gem 'rack-cors', '1.1.1'
