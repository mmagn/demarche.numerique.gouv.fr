# -*- encoding: utf-8 -*-
# stub: faraday-jwt 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "faraday-jwt".freeze
  s.version = "0.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/nov/faraday-jwt/blob/main/CHANGELOG.md", "homepage_uri" => "https://github.com/nov/faraday-jwt", "source_code_uri" => "https://github.com/nov/faraday-jwt" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["nov".freeze]
  s.bindir = "exe".freeze
  s.date = "2022-10-11"
  s.description = "Faraday Middleware for JWT Request & Response".freeze
  s.email = ["nov@matake.jp".freeze]
  s.homepage = "https://github.com/nov/faraday-jwt".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6.0".freeze)
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Faraday Middleware for JWT Request & Response".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<faraday>.freeze, ["~> 2.0".freeze])
  s.add_runtime_dependency(%q<json-jwt>.freeze, ["~> 1.16".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<simplecov>.freeze, [">= 0".freeze])
end
