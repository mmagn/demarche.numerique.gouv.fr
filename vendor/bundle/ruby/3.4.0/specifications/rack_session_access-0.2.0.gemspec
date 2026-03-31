# -*- encoding: utf-8 -*-
# stub: rack_session_access 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rack_session_access".freeze
  s.version = "0.2.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andriy Yanko".freeze]
  s.date = "2018-04-09"
  s.email = ["andriy.yanko@gmail.com".freeze]
  s.homepage = "https://github.com/railsware/rack_session_access".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Rack middleware that provides access to rack.session environment".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<rack>.freeze, [">= 1.0.0".freeze])
  s.add_runtime_dependency(%q<builder>.freeze, [">= 2.0.0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7.0".freeze])
  s.add_development_dependency(%q<capybara>.freeze, ["~> 3.0.1".freeze])
  s.add_development_dependency(%q<chromedriver-helper>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<selenium-webdriver>.freeze, ["~> 3.11.0".freeze])
  s.add_development_dependency(%q<rails>.freeze, [">= 4.0.0".freeze])
end
