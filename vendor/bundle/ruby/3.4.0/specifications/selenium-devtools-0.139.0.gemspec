# -*- encoding: utf-8 -*-
# stub: selenium-devtools 0.139.0 ruby lib

Gem::Specification.new do |s|
  s.name = "selenium-devtools".freeze
  s.version = "0.139.0".freeze

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/SeleniumHQ/selenium/blob/trunk/rb/CHANGES", "funding_uri" => "https://github.com/sponsors/SeleniumHQ", "github_repo" => "ssh://github.com/SeleniumHQ/selenium", "rubygems_mfa_required" => "true", "source_code_uri" => "https://github.com/SeleniumHQ/selenium/tree/trunk/rb" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Alex Rodionov".freeze, "Titus Fortner".freeze, "Thomas Walpole".freeze]
  s.date = "2025-08-12"
  s.description = "    Selenium WebDriver now supports limited DevTools interactions.\n    This project allows users to specify desired versioning.\n".freeze
  s.email = ["p0deje@gmail.com".freeze, "titusfortner@gmail.com".freeze, "twalpole@gmail.com".freeze]
  s.homepage = "https://selenium.dev".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.2".freeze)
  s.rubygems_version = "3.4.19".freeze
  s.summary = "DevTools Code for use with Selenium".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<selenium-webdriver>.freeze, ["~> 4.2".freeze])
end
