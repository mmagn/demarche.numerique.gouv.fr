# -*- encoding: utf-8 -*-
# stub: xmlenc 0.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "xmlenc".freeze
  s.version = "0.8.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Benoist".freeze]
  s.date = "2021-08-23"
  s.description = "A (partial)implementation of the XMLENC specificiation".freeze
  s.email = ["bclaassen@digidentity.eu".freeze]
  s.homepage = "https://github.com/digidentity/xmlenc".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "A (partial)implementation of the XMLENC specificiation".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.0.0".freeze])
  s.add_runtime_dependency(%q<activemodel>.freeze, [">= 3.0.0".freeze])
  s.add_runtime_dependency(%q<xmlmapper>.freeze, [">= 0.7.3".freeze])
  s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 1.6.0".freeze, "< 2.0.0".freeze])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec-rails>.freeze, [">= 2.14".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<coveralls>.freeze, [">= 0".freeze])
end
