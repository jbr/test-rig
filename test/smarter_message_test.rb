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
  
  test 'with four context lines' do
    NeatoAssertions::SmarterMessage.context_lines = context = 4
    e = assert_raise(Test::Unit::AssertionFailedError) { assert false }
    context_output = e.message.split("\n").select{|line| line =~ /^(-->)?\s+[0-9]+:/}
    
    assert_equal context * 2 + 1, context_output.size
    assert_match "test 'with four context lines", context_output[2]
    assert_match /-->.+assert false/, context_output[context]
  end
end



