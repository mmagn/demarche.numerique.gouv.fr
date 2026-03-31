# -*- encoding: utf-8 -*-
# stub: iban-tools 1.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "iban-tools".freeze
  s.version = "1.2.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Iulian Dogariu".freeze, "Tor Erik Linnerud".freeze]
  s.date = "2023-12-04"
  s.description = "Validates IBAN account numbers".freeze
  s.email = ["code@iuliandogariu.com".freeze, "tor@alphasights.com".freeze]
  s.homepage = "https://github.com/alphasights/iban-tools".freeze
  s.licenses = ["MIT".freeze]
  s.requirements = ["none".freeze]
  s.rubygems_version = "3.3.7".freeze
  s.summary = "IBAN validator".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.1".freeze])
  s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.7".freeze])
end
