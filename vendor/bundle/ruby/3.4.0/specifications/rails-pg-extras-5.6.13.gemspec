# -*- encoding: utf-8 -*-
# stub: rails-pg-extras 5.6.13 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-pg-extras".freeze
  s.version = "5.6.13".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "rubygems_mfa_required" => "true" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["pawurb".freeze]
  s.date = "2025-09-07"
  s.description = " Rails port of Heroku PG Extras. The goal of this project is to provide a powerful insights into PostgreSQL database for Ruby on Rails apps that are not using the default Heroku PostgreSQL plugin. ".freeze
  s.email = ["contact@pawelurbanek.com".freeze]
  s.homepage = "http://github.com/pawurb/rails-pg-extras".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.5.16".freeze
  s.summary = "Rails PostgreSQL performance database insights".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<ruby-pg-extras>.freeze, ["= 5.6.13".freeze])
  s.add_runtime_dependency(%q<railties>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<actionpack>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<activerecord>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rufo>.freeze, [">= 0".freeze])
end
