# -*- encoding: utf-8 -*-
# stub: string-similarity 2.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "string-similarity".freeze
  s.version = "2.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Manuel Hutter".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-03-17"
  s.description = "== Description\n\nThis gem provides some methods for calculating similarities of two strings.\n\n=== Currently implemented\n\n- Cosine similarity\n- Levenshtein distance/similarity\n\n=== Planned\n\n- Hamming similarity\n".freeze
  s.email = ["manuel@hutter.io".freeze]
  s.homepage = "https://github.com/mhutter/string-similarity".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Various methods for calculating string similarities.".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, ["~> 13.0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<pry>.freeze, [">= 0".freeze])
end
