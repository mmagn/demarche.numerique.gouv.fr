# -*- encoding: utf-8 -*-
# stub: langchainrb 0.19.3 ruby lib

Gem::Specification.new do |s|
  s.name = "langchainrb".freeze
  s.version = "0.19.3".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/patterns-ai-core/langchainrb/blob/main/CHANGELOG.md", "documentation_uri" => "https://rubydoc.info/gems/langchainrb", "homepage_uri" => "https://rubygems.org/gems/langchainrb", "source_code_uri" => "https://github.com/patterns-ai-core/langchainrb" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andrei Bondarev".freeze]
  s.bindir = "exe".freeze
  s.date = "2025-01-13"
  s.description = "Build LLM-backed Ruby applications with Ruby's Langchain.rb".freeze
  s.email = ["andrei.bondarev13@gmail.com".freeze]
  s.homepage = "https://rubygems.org/gems/langchainrb".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.1.0".freeze)
  s.rubygems_version = "3.5.3".freeze
  s.summary = "Build LLM-backed Ruby applications with Ruby's Langchain.rb".freeze

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<baran>.freeze, ["~> 0.1.9".freeze])
  s.add_runtime_dependency(%q<csv>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<json-schema>.freeze, ["~> 4".freeze])
  s.add_runtime_dependency(%q<zeitwerk>.freeze, ["~> 2.5".freeze])
  s.add_runtime_dependency(%q<pragmatic_segmenter>.freeze, ["~> 0.3.0".freeze])
  s.add_runtime_dependency(%q<matrix>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<dotenv-rails>.freeze, ["~> 3.1.6".freeze])
  s.add_development_dependency(%q<pry-byebug>.freeze, ["~> 3.10.0".freeze])
  s.add_development_dependency(%q<yard>.freeze, ["~> 0.9.34".freeze])
  s.add_development_dependency(%q<rdiscount>.freeze, ["~> 2.2.7".freeze])
  s.add_development_dependency(%q<vcr>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<webmock>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<ai21>.freeze, ["~> 0.2.1".freeze])
  s.add_development_dependency(%q<anthropic>.freeze, ["~> 0.3".freeze])
  s.add_development_dependency(%q<aws-sdk-bedrockruntime>.freeze, ["~> 1.1".freeze])
  s.add_development_dependency(%q<chroma-db>.freeze, ["~> 0.6.0".freeze])
  s.add_development_dependency(%q<cohere-ruby>.freeze, ["~> 0.9.10".freeze])
  s.add_development_dependency(%q<docx>.freeze, ["~> 0.8.0".freeze])
  s.add_development_dependency(%q<elasticsearch>.freeze, ["~> 8.2.0".freeze])
  s.add_development_dependency(%q<epsilla-ruby>.freeze, ["~> 0.0.4".freeze])
  s.add_development_dependency(%q<eqn>.freeze, ["~> 1.6.5".freeze])
  s.add_development_dependency(%q<faraday>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<googleauth>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<google_search_results>.freeze, ["~> 2.0.0".freeze])
  s.add_development_dependency(%q<hnswlib>.freeze, ["~> 0.8.1".freeze])
  s.add_development_dependency(%q<hugging-face>.freeze, ["~> 0.3.4".freeze])
  s.add_development_dependency(%q<milvus>.freeze, ["~> 0.10.3".freeze])
  s.add_development_dependency(%q<llama_cpp>.freeze, ["~> 0.9.4".freeze])
  s.add_development_dependency(%q<nokogiri>.freeze, ["~> 1.13".freeze])
  s.add_development_dependency(%q<mail>.freeze, ["~> 2.8".freeze])
  s.add_development_dependency(%q<mistral-ai>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<pg>.freeze, ["~> 1.5".freeze])
  s.add_development_dependency(%q<pgvector>.freeze, ["~> 0.2.1".freeze])
  s.add_development_dependency(%q<pdf-reader>.freeze, ["~> 2.0".freeze])
  s.add_development_dependency(%q<pinecone>.freeze, ["~> 0.1.6".freeze])
  s.add_development_dependency(%q<replicate-ruby>.freeze, ["~> 0.2.2".freeze])
  s.add_development_dependency(%q<qdrant-ruby>.freeze, ["~> 0.9.8".freeze])
  s.add_development_dependency(%q<roo>.freeze, ["~> 2.10.0".freeze])
  s.add_development_dependency(%q<roo-xls>.freeze, ["~> 1.2.0".freeze])
  s.add_development_dependency(%q<ruby-openai>.freeze, ["~> 7.1.0".freeze])
  s.add_development_dependency(%q<safe_ruby>.freeze, ["~> 1.0.4".freeze])
  s.add_development_dependency(%q<sequel>.freeze, ["~> 5.87.0".freeze])
  s.add_development_dependency(%q<weaviate-ruby>.freeze, ["~> 0.9.2".freeze])
  s.add_development_dependency(%q<wikipedia-client>.freeze, ["~> 1.17.0".freeze])
  s.add_development_dependency(%q<power_point_pptx>.freeze, ["~> 0.1.0".freeze])
end
