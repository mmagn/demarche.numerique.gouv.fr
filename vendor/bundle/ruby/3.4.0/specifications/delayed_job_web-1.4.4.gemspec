# -*- encoding: utf-8 -*-
# stub: delayed_job_web 1.4.4 ruby lib

Gem::Specification.new do |s|
  s.name = "delayed_job_web".freeze
  s.version = "1.4.4".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Erick Schmitt".freeze]
  s.date = "2021-03-02"
  s.description = "Web interface for delayed_job inspired by resque".freeze
  s.email = "ejschmitt@gmail.com".freeze
  s.executables = ["delayed_job_web".freeze]
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.markdown".freeze]
  s.files = ["LICENSE.txt".freeze, "README.markdown".freeze, "bin/delayed_job_web".freeze]
  s.homepage = "https://github.com/ejschmitt/delayed_job_web".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Web interface for delayed_job inspired by resque".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<sinatra>.freeze, [">= 1.4.4".freeze])
  s.add_runtime_dependency(%q<rack-protection>.freeze, [">= 1.5.5".freeze])
  s.add_runtime_dependency(%q<activerecord>.freeze, ["> 3.0.0".freeze])
  s.add_runtime_dependency(%q<delayed_job>.freeze, ["> 2.0.3".freeze])
  s.add_development_dependency(%q<minitest>.freeze, ["~> 4.2".freeze])
  s.add_development_dependency(%q<rack-test>.freeze, ["~> 0.6".freeze])
  s.add_development_dependency(%q<rails>.freeze, ["~> 4.0".freeze])
end
