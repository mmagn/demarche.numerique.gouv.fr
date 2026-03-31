# -*- encoding: utf-8 -*-
# stub: fog-openstack 1.1.5 ruby lib

Gem::Specification.new do |s|
  s.name = "fog-openstack".freeze
  s.version = "1.1.5".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Matt Darby".freeze]
  s.bindir = "exe".freeze
  s.date = "2025-03-18"
  s.description = "OpenStack fog provider gem.".freeze
  s.email = ["matt.darby@rackspace.com".freeze]
  s.homepage = "https://github.com/fog/fog-openstack".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0".freeze)
  s.rubygems_version = "3.5.18".freeze
  s.summary = "OpenStack fog provider gem".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<fog-core>.freeze, ["~> 2.1".freeze])
  s.add_runtime_dependency(%q<fog-json>.freeze, [">= 1.0".freeze])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<coveralls>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<mime-types>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<mime-types-data>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<pry-byebug>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 12.3.3".freeze])
  s.add_development_dependency(%q<rubocop>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<shindo>.freeze, ["~> 0.3".freeze])
  s.add_development_dependency(%q<vcr>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<webmock>.freeze, ["~> 3.16.2".freeze])
end
