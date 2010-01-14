require 'active_support'

module TestRig
  module DynamicAssertions
    def self.included(klass)
      klass.class_eval do
        alias_method_chain :method_missing, :dynamic_assertions
      end
    end
    
    def assert_not(*args)
      assert !args.shift, *args
    end
    
    def method_missing_with_dynamic_assertions(method, *args)
      case method.to_s
      when /^assert_no_([a-z_]+)$/
        method_name = $1.to_sym
        if args.first.respond_to? method_name
          assert_nil args.first.send(method_name)
          return
        end
      when /^assert_(not_)?([a-z_]+)$/
        method_name = $2.to_sym
        if args.length == 1 && args.first.respond_to?(:"#{method_name}?")
          actual = args.first.send :"#{method_name}?"
          assert $1 ? !actual : actual
          return
        elsif args.length == 2 && args.last.respond_to?(method_name)
          send :"assert_#{$1}equal", args.first, args.last.send(method_name)
          return
        end
      end

      method_missing_without_dynamic_assertions(method, *args)
    end
  end
end