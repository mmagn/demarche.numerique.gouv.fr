# -*- encoding: utf-8 -*-
# stub: prawn-rails 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "prawn-rails".freeze
  s.version = "1.6.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Carlos Ortiz".freeze, "Weston Ganger".freeze]
  s.date = "2024-12-20"
  s.description = "Prawn Handler for Rails. Handles and registers pdf formats.".freeze
  s.email = "weston@westonganger.com".freeze
  s.homepage = "https://github.com/cortiz/prawn-rails".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "3.4.22".freeze
  s.summary = "Prawn Handler for Rails".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<prawn>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<prawn-table>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<actionview>.freeze, [">= 3.1.0".freeze])
  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.1.0".freeze])
  s.add_development_dependency(%q<pdf-reader>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<pry>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<warning>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<matrix>.freeze, [">= 0".freeze])
end
