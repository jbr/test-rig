ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  include NeatoAssertions
   self.use_transactional_fixtures = true

  fixtures :all

  def assert_false(assertion, message = nil)
    assert !assertion, message
  end
end
