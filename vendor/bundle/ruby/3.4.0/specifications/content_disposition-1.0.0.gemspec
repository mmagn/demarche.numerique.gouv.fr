# -*- encoding: utf-8 -*-
# stub: content_disposition 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "content_disposition".freeze
  s.version = "1.0.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jonathan Rochkind".freeze]
  s.date = "2018-12-18"
  s.email = ["jrochkind@chemheritage.org".freeze]
  s.homepage = "https://github.com/shrinerb/content_disposition".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Ruby gem to create HTTP Content-Disposition headers with proper escaping/encoding of filenames".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.17".freeze])
  s.add_development_dependency(%q<rake>.freeze, ["~> 10.0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0".freeze])
end
