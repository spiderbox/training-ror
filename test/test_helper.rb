ActiveRecord::Migration.maintain_test_schema!

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'helpers/password_helper'

class ActiveSupport::TestCase
  include TestPasswordHelper
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  ActiveRecord::FixtureSet.context_class.include TestPasswordHelper

  # Add more helper methods to be used by all tests here...
end
