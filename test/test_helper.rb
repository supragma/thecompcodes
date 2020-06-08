# frozen_string_literal: true

require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

require 'simplecov'
SimpleCov.start

if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

module Test
  class ActiveSupport
    class TestCase
      # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
      fixtures :all

      # Add more helper methods to be used by all tests here...
    end
  end
end
