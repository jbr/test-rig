require File.join(File.dirname(__FILE__), "test_helper")
require 'smarter_message'


class SmarterMessageTest < Test::Unit::TestCase
  include NeatoAssertions::SmarterMessage
  
  test "smarter message includes the relevent snippet" do
    begin
      a = 'foo'
      b = 'bar'
      assert_equal a, b
    rescue => e
      [
        "<\"foo\"> expected but was\n<\"bar\">.",
        "assert_equal a, b",
        "--> 12",
        "a = 'foo'"
      ].each {|snippet| assert_match snippet, e.message}
    end
  end

  test "backtrace includes only relevant lines" do
    begin
      assert false
    rescue => e
      [
        "backtrace includes only relevant lines",
        "#{__FILE__}:25"
      ].each {|snippet| assert_match snippet, e.backtrace.first}
    end
  end
end
