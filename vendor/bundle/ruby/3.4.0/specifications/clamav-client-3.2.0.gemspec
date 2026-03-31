# -*- encoding: utf-8 -*-
# stub: clamav-client 3.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "clamav-client".freeze
  s.version = "3.2.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Franck Verrot".freeze]
  s.date = "2020-02-14"
  s.description = "ClamAV::Client connects to a Clam Anti-Virus clam daemon and send commands.".freeze
  s.email = ["franck@verrot.fr".freeze]
  s.homepage = "https://github.com/franckverrot/clamav-client".freeze
  s.licenses = ["GPL-v3".freeze]
  s.rubygems_version = "3.0.2".freeze
  s.summary = "ClamAV::Client connects to a Clam Anti-Virus clam daemon and send commands.".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<pry>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0".freeze])
end
