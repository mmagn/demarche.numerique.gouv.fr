# -*- encoding: utf-8 -*-
# stub: dumb_delegator 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "dumb_delegator".freeze
  s.version = "1.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/stevenharman/dumb_delegator/blob/master/CHANGELOG.md", "documentation_uri" => "https://rubydoc.info/gems/dumb_delegator", "homepage_uri" => "https://github.com/stevenharman/dumb_delegator", "source_code_uri" => "https://github.com/stevenharman/dumb_delegator" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andy Lindeman".freeze, "Steven Harman".freeze]
  s.bindir = "exe".freeze
  s.date = "2024-12-17"
  s.description = "Delegator and SimpleDelegator in Ruby's stdlib are useful, but they pull in most of Kernel.\nThis is not appropriate for many uses; for instance, delegation to Rails Models.\nDumbDelegator, on the other hand, delegates nearly everything to the wrapped object.\n".freeze
  s.email = ["alindeman@gmail.com".freeze, "steven@harmanly.com".freeze]
  s.homepage = "https://github.com/stevenharman/dumb_delegator".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.5.23".freeze
  s.summary = "Delegator class that delegates ALL the things".freeze

  s.installed_by_version = "3.6.9".freeze
end
