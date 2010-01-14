require File.join(File.dirname(__FILE__), "test_helper")

class Entry
  def published?() false end
  def saved?() true end
  def user() "joe" end
  def something_nil() nil end
  def something_not_nil() "not nil" end
end

class DynamicAssertionsTest < Test::Unit::TestCase
  include TestRig::DynamicAssertions

  def setup
    @entry = Entry.new
  end
  
  test 'assert not' do
    assert_not @entry.published?
  end
  
  test 'assert not failure' do
    assert_test_failure { assert_not @entry.saved? }
  end
  
  test "positive assertion" do
    assert_saved @entry
  end
  
  test "positive assertion failure" do
    assert_test_failure { assert_not_saved @entry }
  end
  
  test "negative assertion" do
    assert_not_published @entry
  end
  
  test "negative assertion failure" do
    assert_test_failure { assert_published @entry }
  end
  
  test "positive equality assertion" do
    assert_user "joe", @entry
  end
  
  test 'positive equality assertion failure' do
    assert_test_failure { assert_user 'sue', @entry }
  end
  
  test "negative equality assertion" do
    assert_not_user "sally", @entry
  end
  
  test 'negative equality assertion failure' do
    assert_test_failure { assert_not_user 'joe', @entry }
  end
  
  test "assert no" do
    assert_no_something_nil @entry
  end
  
  test "assert no failure" do
    assert_test_failure { assert_no_something_not_nil @entry }
  end
end