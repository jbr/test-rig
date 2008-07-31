module NeatoAssertions

  def method_missing_with_neato_assertions(method, *args)
    if method.to_s =~ /^assert_(not_)?([a-z_]+)\??/ && args.first.respond_to?(:"#{$2}?")
      actual = args.first.send(:"#{$2}?")
      assert $1 ? !actual : actual
    else
      method_missing_without_neato_assertions(method, *args)
    end
  end

  def self.included(klass)
    klass.class_eval do
      alias_method_chain :method_missing, :neato_assertions
      alias_method_chain :assert, :smarter_message
    end
  end

  def assert_with_smarter_message(*args)
    assert_without_smarter_message(*args)
  rescue Test::Unit::AssertionFailedError => e
    message = message_for_backtrace(e.backtrace)
    new_error = Test::Unit::AssertionFailedError.new message
    new_error.set_backtrace(e.backtrace)
    raise new_error
  end



  private


  def message_for(assertion_type, assertion)
    "``#{assertion}''" << case assertion_type
    when 'assert_nil' then "``#{assertion}'' was not nil"
    when 'assert_not_nil' then "``#{assertion}'' was nil"
    when 'assert' then "``#{assertion}'' was not true"
    else "#{assertion_type} for #{assertion}"
    end
  end
  
  def message_for_backtrace(backtrace)
    line = line_at_backtrace(backtrace)
    line.scan(/([a-z_]+)(?:\((.*)\)$|\s(.*)$)/).flatten.compact
    assertion_type, assertion = line.scan(/([a-z_]+)(?:\((.*)\)$|\s(.*)$)/).flatten.compact
    message_for assertion_type, assertion
  end
  
  def line_at_backtrace(backtrace)
     backtrace
    first_test_line = backtrace.detect { |trace| trace =~ /_test\.rb/}
    file, line = first_test_line.split(":")
    File.open(file).readlines[line.to_i - 1].strip
  end


end
