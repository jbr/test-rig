# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{test-rig}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jacob Rothstein"]
  s.date = %q{2009-10-22}
  s.description = %q{TestRig supplies dynamic assertions and contextual failure messages}
  s.email = %q{github@jacobrothstein.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.textile"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.textile",
     "Rakefile",
     "VERSION",
     "lib/test_rig.rb",
     "lib/test_rig/dynamic_assertions.rb",
     "lib/test_rig/smarter_message.rb",
     "test-rig.gemspec",
     "test/dynamic_assertions_test.rb",
     "test/smarter_message_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/jbr/test-rig}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{TestRig makes Test::Unit fun again}
  s.test_files = [
    "test/dynamic_assertions_test.rb",
     "test/smarter_message_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
