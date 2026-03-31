# -*- encoding: utf-8 -*-
# stub: zipline 2.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "zipline".freeze
  s.version = "2.0.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ram Dobson".freeze]
  s.date = "2024-03-18"
  s.description = "a module for streaming dynamically generated zip files".freeze
  s.email = ["ram.dobson@solsystemscompany.com".freeze]
  s.homepage = "http://github.com/fringd/zipline".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7".freeze)
  s.rubygems_version = "3.3.26".freeze
  s.summary = "stream zip files from rails".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<actionpack>.freeze, [">= 6.0".freeze, "< 8.0".freeze])
  s.add_runtime_dependency(%q<content_disposition>.freeze, ["~> 1.0".freeze])
  s.add_runtime_dependency(%q<zip_kit>.freeze, ["~> 6".freeze, ">= 6.2.0".freeze, "< 7".freeze])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3".freeze])
  s.add_development_dependency(%q<fog-aws>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<aws-sdk-s3>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<carrierwave>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<paperclip>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec-mocks>.freeze, ["~> 3.12".freeze])
end
