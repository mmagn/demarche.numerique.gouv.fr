# -*- encoding: utf-8 -*-
# stub: spring-commands-rspec 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "spring-commands-rspec".freeze
  s.version = "1.0.4".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jon Leighton".freeze]
  s.date = "2014-12-13"
  s.description = "rspec command for spring".freeze
  s.email = ["j@jonathanleighton.com".freeze]
  s.homepage = "https://github.com/jonleighton/spring-commands-rspec".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.2.2".freeze
  s.summary = "rspec command for spring".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<spring>.freeze, [">= 0.9.1".freeze])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
end
