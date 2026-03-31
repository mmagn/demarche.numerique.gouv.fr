# -*- encoding: utf-8 -*-
# stub: rake-progressbar 0.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "rake-progressbar".freeze
  s.version = "0.0.5".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ondrej Bartas".freeze]
  s.date = "2012-02-25"
  s.description = "Easy to use, shows estimated time to finish, elapsed time, percantage, not slowing with very fast jobs (terminal rescreen issue)".freeze
  s.email = "o.bartas@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/ondrejbartas/rake-progressbar".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "1.8.10".freeze
  s.summary = "Showing progress of long going rake tasks - importing, archivieng etc.".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 3

  s.add_development_dependency(%q<shoulda>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0.0".freeze])
  s.add_development_dependency(%q<jeweler>.freeze, ["~> 1.6.4".freeze])
end
