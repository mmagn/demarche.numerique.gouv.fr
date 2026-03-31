# -*- encoding: utf-8 -*-
# stub: activestorage-openstack 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "activestorage-openstack".freeze
  s.version = "1.6.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 1.8.11".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chedli Bourguiba".freeze]
  s.date = "2022-10-08"
  s.description = "Wraps the OpenStack Swift/Storage service as an Active Storage service".freeze
  s.email = ["bourguiba.chedli@gmail.com".freeze]
  s.homepage = "https://github.com/chaadow/activestorage-openstack".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0".freeze)
  s.rubygems_version = "3.1.6".freeze
  s.summary = "ActiveStorage wrapper for OpenStack Storage".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<fog-openstack>.freeze, [">= 1.0.9".freeze])
  s.add_runtime_dependency(%q<marcel>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<rails>.freeze, [">= 5.2.2".freeze])
  s.add_development_dependency(%q<appraisal>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<sqlite3>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<simplecov>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<simplecov-console>.freeze, [">= 0".freeze])
end
