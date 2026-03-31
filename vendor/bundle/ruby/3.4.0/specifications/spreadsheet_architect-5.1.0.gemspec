# -*- encoding: utf-8 -*-
# stub: spreadsheet_architect 5.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "spreadsheet_architect".freeze
  s.version = "5.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Weston Ganger".freeze]
  s.date = "2025-01-07"
  s.description = "Spreadsheet Architect is a library that allows you to create XLSX, ODS, or CSV spreadsheets easily from ActiveRecord relations, Plain Ruby classes, or predefined data.".freeze
  s.email = "weston@westonganger.com".freeze
  s.homepage = "https://github.com/westonganger/spreadsheet_architect".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.22".freeze
  s.summary = "Spreadsheet Architect is a library that allows you to create XLSX, ODS, or CSV spreadsheets easily from ActiveRecord relations, Plain Ruby classes, or predefined data.".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<caxlsx>.freeze, ["<= 4.0".freeze])
  s.add_runtime_dependency(%q<rodf>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<csv>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest-reporters>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<warning>.freeze, [">= 0".freeze])
end
