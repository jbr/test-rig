require 'rubygems'
require 'active_support'
require 'test/unit'
$:.unshift File.instance_eval { expand_path join(dirname(__FILE__), "..", "lib", "neato_assertions") }

class Test::Unit::TestCase
  def self.test(name, &blk) define_method(:"test #{name}", &blk) end
end
