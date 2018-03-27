ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'


# include all support helpers
Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Includes helper methods modules to be used by all tests
  include JsonHelper
  include AuthHelper


  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest

  include JsonHelper
  include AuthHelper

end
