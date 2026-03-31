# -*- encoding: utf-8 -*-
# stub: rodf 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rodf".freeze
  s.version = "1.2.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Weston Ganger".freeze, "Thiago Arrais".freeze]
  s.date = "2021-12-21"
  s.description = "ODF generation library for Ruby".freeze
  s.email = ["weston@westonganger.com".freeze, "thiago.arrais@gmail.com".freeze]
  s.homepage = "https://github.com/thiagoarrais/rodf".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "This is a library for writing to ODF output from Ruby. It mainly focuses creating ODS spreadsheets.".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<builder>.freeze, [">= 3.0".freeze])
  s.add_runtime_dependency(%q<rubyzip>.freeze, [">= 1.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 2.9".freeze])
  s.add_development_dependency(%q<hpricot>.freeze, [">= 0.8.6".freeze])
  s.add_development_dependency(%q<rspec_hpricot_matchers>.freeze, [">= 1.0".freeze])
end
