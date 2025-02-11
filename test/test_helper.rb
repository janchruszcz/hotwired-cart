ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
# require "minitest/rails"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def number_to_currency(number)
      ActionController::Base.helpers.number_to_currency(number)
    end
  end
end

class ActionDispatch::IntegrationTest
  def set_cart_path(cart)
    "/test/set_cart/#{cart.id}"
  end
end
