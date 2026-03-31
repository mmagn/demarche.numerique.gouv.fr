# -*- encoding: utf-8 -*-
# stub: saml_idp 0.16.0 ruby lib

Gem::Specification.new do |s|
  s.name = "saml_idp".freeze
  s.version = "0.16.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/saml-idp/saml_idp/issues", "documentation_uri" => "http://rdoc.info/gems/saml_idp/0.16.0", "homepage_uri" => "https://github.com/saml-idp/saml_idp", "source_code_uri" => "https://github.com/saml-idp/saml_idp" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jon Phenow".freeze]
  s.date = "2024-01-05"
  s.description = "SAML IdP (Identity Provider) Library for Ruby".freeze
  s.email = "jon.phenow@sportngin.com".freeze
  s.homepage = "https://github.com/saml-idp/saml_idp".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "    If you're just recently updating saml_idp - please be aware we've changed the default\n    certificate. See the PR and a description of why we've done this here:\n    https://github.com/saml-idp/saml_idp/pull/29\n\n    If you just need to see the certificate `bundle open saml_idp` and go to\n    `lib/saml_idp/default.rb`\n\n    Similarly, please see the README about certificates - you should avoid using the\n    defaults in a Production environment. Post any issues you to github.\n\n    ** New in Version 0.3.0 **\n    Encrypted Assertions require the xmlenc gem. See the example in the Controller\n    section of the README.\n".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5".freeze)
  s.rubygems_version = "3.3.7".freeze
  s.summary = "SAML Indentity Provider for Ruby".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.2".freeze])
  s.add_runtime_dependency(%q<builder>.freeze, [">= 3.0".freeze])
  s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 1.6.2".freeze])
  s.add_runtime_dependency(%q<rexml>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<xmlenc>.freeze, [">= 0.7.1".freeze])
  s.add_development_dependency(%q<activeresource>.freeze, [">= 5.1".freeze])
  s.add_development_dependency(%q<appraisal>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<byebug>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<capybara>.freeze, [">= 2.16".freeze])
  s.add_development_dependency(%q<rails>.freeze, [">= 5.2".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 3.7.0".freeze])
  s.add_development_dependency(%q<ruby-saml>.freeze, [">= 1.7.2".freeze])
  s.add_development_dependency(%q<simplecov>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<timecop>.freeze, [">= 0.8".freeze])
end
