require 'test/unit'
require 'test_helper'
require '../lib/neato_assertions/smarter_message'

class SmarterMessageTest < Test::Unit::TestCase
  include NeatoAssertions::SmarterMessage
  
  define_method :"test smarter message includes the relevent snippet" do
    begin
      a = 'foo'
      b = 'bar'
      assert_equal a, b
    rescue => e
      [
        "<\"foo\"> expected but was\n<\"bar\">.",
        "assert_equal a, b",
        "--> 12"
      ].each {|snippet| assert_match snippet, e.message}
    end
  end

  define_method :"test backtrace includes only relevant lines" do
    begin
      assert false
    rescue => e
      assert_equal 2, e.backtrace.length
      assert_match "backtrace includes only relevant lines", e.backtrace.first
      assert_match "#{__FILE__}:24", e.backtrace.first
      assert_match "#{__FILE__}:22", e.backtrace.last
    end
  end
end
