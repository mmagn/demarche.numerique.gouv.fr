# -*- encoding: utf-8 -*-
# stub: ruby-pg-extras 5.6.13 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-pg-extras".freeze
  s.version = "5.6.13".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["pawurb".freeze]
  s.date = "2025-09-07"
  s.description = " Ruby port of Heroku PG Extras. The goal of this project is to provide a powerful insights into PostgreSQL database for Ruby on Rails apps that are not using the default Heroku PostgreSQL plugin. ".freeze
  s.email = ["contact@pawelurbanek.com".freeze]
  s.homepage = "http://github.com/pawurb/ruby-pg-extras".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.5.16".freeze
  s.summary = "Ruby PostgreSQL performance database insights".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<pg>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<terminal-table>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rufo>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<dbg-rb>.freeze, [">= 0".freeze])
end
