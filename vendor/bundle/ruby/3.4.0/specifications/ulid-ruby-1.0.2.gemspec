# -*- encoding: utf-8 -*-
# stub: ulid-ruby 1.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ulid-ruby".freeze
  s.version = "1.0.2".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Adam Bachman".freeze]
  s.bindir = "exe".freeze
  s.date = "2022-01-19"
  s.description = "\n    Ruby library providing support for Universally unique Lexicographically\n    Sortable Identifiers. ULIDs are helpful in systems where you need to\n    generate ID values that are absolutely lexicographically sortable by time,\n    regardless of where they were generated.\n  ".freeze
  s.email = ["adam.bachman@gmail.com".freeze]
  s.homepage = "https://github.com/abachman/ulid-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.3".freeze
  s.summary = "Ruby library providing support for Universally unique Lexicographically sortable IDentifiers".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, ["~> 2".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 12.3.3".freeze])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0".freeze])
  s.add_development_dependency(%q<yard>.freeze, ["~> 0.9".freeze])
end
