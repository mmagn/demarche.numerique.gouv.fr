# -*- encoding: utf-8 -*-
# stub: haml_to_erb 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "haml_to_erb".freeze
  s.version = "0.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/kurioscreative/haml_to_erb/issues", "changelog_uri" => "https://github.com/kurioscreative/haml_to_erb/blob/main/CHANGELOG.md", "homepage_uri" => "https://github.com/kurioscreative/haml_to_erb", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/kurioscreative/haml_to_erb/tree/main" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Glenn Ericksen".freeze]
  s.bindir = "exe".freeze
  s.date = "1980-01-02"
  s.description = "A HAML to ERB converter for migrating Rails views. Handles tags, attributes, Ruby code, blocks, filters, and interpolation.".freeze
  s.email = ["glenn.m.ericksen@gmail.com".freeze]
  s.executables = ["haml_to_erb".freeze]
  s.files = ["exe/haml_to_erb".freeze]
  s.homepage = "https://github.com/kurioscreative/haml_to_erb".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.2.0".freeze)
  s.rubygems_version = "3.6.9".freeze
  s.summary = "Convert HAML templates to ERB".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<haml>.freeze, [">= 5.0".freeze, "< 8".freeze])
  s.add_runtime_dependency(%q<prism>.freeze, [">= 0.24".freeze, "< 2".freeze])
  s.add_development_dependency(%q<herb>.freeze, ["~> 0.8".freeze])
end
