# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module LoginHelper
  def log_in_as(user)
    post login_url, params: { email: user.email, password: 'password' }
  end
end

module ActionDispatch
  class IntegrationTest
    include LoginHelper
  end
end
