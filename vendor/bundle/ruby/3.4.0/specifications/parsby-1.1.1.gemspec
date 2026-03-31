# -*- encoding: utf-8 -*-
# stub: parsby 1.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "parsby".freeze
  s.version = "1.1.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/jolmg/parsby/blob/master/CHANGELOG.md" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jorge Luis Martinez Gomez".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-09-26"
  s.email = ["jol@jol.dev".freeze]
  s.homepage = "https://github.com/jolmg/parsby".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Parser combinator library inspired by Haskell's Parsec".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.17".freeze])
  s.add_development_dependency(%q<rake>.freeze, ["~> 10.0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0".freeze])
  s.add_development_dependency(%q<pry>.freeze, ["~> 0".freeze])
end
