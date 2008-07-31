require 'test/unit'
require 'rubygems'
require 'activesupport'
require 'neato_assertions'

class Foo
  def wibble?
    true
  end
  
  def bar?
    false
  end
end
  

class NeatoAssertionsTest < Test::Unit::TestCase
  include NeatoAssertions
  
  def test_neato_assertions
    foo = Foo.new
    assert_wibble foo
    assert_wibble? foo
    assert_raise(Test::Unit::AssertionFailedError) {assert_not_wibble foo}

    assert_not_bar foo
    assert_not_bar? foo
    assert_raise(Test::Unit::AssertionFailedError) {assert_bar foo}
  end
end
