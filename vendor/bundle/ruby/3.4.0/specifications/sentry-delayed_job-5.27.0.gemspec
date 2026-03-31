# -*- encoding: utf-8 -*-
# stub: sentry-delayed_job 5.27.0 ruby lib

Gem::Specification.new do |s|
  s.name = "sentry-delayed_job".freeze
  s.version = "5.27.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/getsentry/sentry-ruby/issues", "changelog_uri" => "https://github.com/getsentry/sentry-ruby/blob/5.27.0/CHANGELOG.md", "documentation_uri" => "http://www.rubydoc.info/gems/sentry-delayed_job/5.27.0", "homepage_uri" => "https://github.com/getsentry/sentry-ruby/tree/5.27.0/sentry-delayed_job", "source_code_uri" => "https://github.com/getsentry/sentry-ruby/tree/5.27.0/sentry-delayed_job" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sentry Team".freeze]
  s.bindir = "exe".freeze
  s.date = "1980-01-02"
  s.description = "A gem that provides DelayedJob integration for the Sentry error logger".freeze
  s.email = "accounts@sentry.io".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.files = ["LICENSE.txt".freeze, "README.md".freeze]
  s.homepage = "https://github.com/getsentry/sentry-ruby/tree/5.27.0/sentry-delayed_job".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.6.9".freeze
  s.summary = "A gem that provides DelayedJob integration for the Sentry error logger".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<sentry-ruby>.freeze, ["~> 5.27.0".freeze])
  s.add_runtime_dependency(%q<delayed_job>.freeze, [">= 4.0".freeze])
end
