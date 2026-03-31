# -*- encoding: utf-8 -*-
# stub: simple_xlsx_reader 5.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "simple_xlsx_reader".freeze
  s.version = "5.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Woody Peterson".freeze]
  s.date = "2025-04-10"
  s.description = "Read xlsx data the Ruby way".freeze
  s.email = ["woody.peterson@gmail.com".freeze]
  s.homepage = "".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.5.22".freeze
  s.summary = "Read xlsx data the Ruby way".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<rubyzip>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 5.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<pry>.freeze, [">= 0".freeze])
end
