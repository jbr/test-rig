require File.join(File.dirname(__FILE__), "test_helper")
require 'dynamic_assertions'

class Entry
  def published?() false end
  def saved?() true end
  def user() "joe" end
end

class DynamicAssertionsTest < Test::Unit::TestCase
  include NeatoAssertions::DynamicAssertions
  def self.test(name, &blk) define_method(:"test #{name}", &blk) end
  
  def setup
    @entry = Entry.new
  end
  
  test "positive assertion" do
    assert_saved @entry
  end
  
  test "positive assertion failure" do
    assert_raise Test::Unit::AssertionFailedError do
      assert_not_saved @entry
    end
  end
  
  test "negative assertion" do
    assert_not_published @entry
  end
  
  test "negative assertion failure" do
    assert_raise Test::Unit::AssertionFailedError do
      assert_published @entry
    end
  end
  
  test "positive equals assertion" do
    assert_user "joe", @entry
  end
  
  test "negative equals assertion" do
    assert_not_user "sally", @entry
  end
end