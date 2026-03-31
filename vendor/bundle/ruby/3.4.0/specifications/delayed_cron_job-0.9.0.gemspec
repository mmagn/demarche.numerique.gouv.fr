# -*- encoding: utf-8 -*-
# stub: delayed_cron_job 0.9.0 ruby lib

Gem::Specification.new do |s|
  s.name = "delayed_cron_job".freeze
  s.version = "0.9.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Pascal Zumkehr".freeze]
  s.date = "2021-11-09"
  s.description = "Delayed Cron Job is an extension to Delayed::Job\n                          that allows you to set cron expressions for your\n                          jobs to run regularly.".freeze
  s.email = ["spam@codez.ch".freeze]
  s.homepage = "https://github.com/codez/delayed_cron_job".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "An extension to Delayed::Job that allows you to set cron expressions for your jobs to run regularly.".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<fugit>.freeze, [">= 1.5".freeze])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<sqlite3>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<delayed_job_active_record>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<activejob>.freeze, [">= 0".freeze])
end
