require 'test/unit'
require 'test_helper'
require '../lib/neato_assertions/dynamic_assertions'

class Foo
  def wibble?
    true
  end
  
  def bar?
    false
  end
  
  def string() "hello" end
end
  

class NeatoAssertionsTest < Test::Unit::TestCase
  include ::NeatoAssertions::DynamicAssertions
  
  def test_neato_assertions
    foo = Foo.new
    assert_wibble foo
    assert_wibble? foo
    assert_raise(Test::Unit::AssertionFailedError) {assert_not_wibble foo}

    assert_not_bar foo
    assert_not_bar? foo
    assert_raise(Test::Unit::AssertionFailedError) {assert_bar foo}
    
    assert_string "hello", foo
  end
end
