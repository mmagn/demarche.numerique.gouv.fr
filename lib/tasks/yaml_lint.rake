# frozen_string_literal: true

namespace :lint do
  desc 'Check for missing final newline in YAML files'
  task :yaml_newline do
    files_without_newline = []

    Dir.glob('{app,config,spec}/**/*.yml').each do |file|
      content = File.read(file)
      files_without_newline << file if content.present? && !content.end_with?("\n")
    end

    if files_without_newline.any?
      puts
      files_without_newline.each { |f| puts "  #{f}" }
      puts
      puts "❌ Found #{files_without_newline.size} YAML file(s) missing final newline"
      puts "To fix, run: bundle exec rake lint:yaml_newline:fix"
      puts
      exit 1
    else
      puts "✅ All YAML files have a final newline"
    end
  end

  desc 'Fix missing final newline in YAML files'
  task 'yaml_newline:fix' do
    fixed_files = []

    Dir.glob('{app,config,spec}/**/*.yml').each do |file|
      content = File.read(file)
      if content.present? && !content.end_with?("\n")
        File.write(file, content + "\n")
        fixed_files << file
      end
    end

    if fixed_files.any?
      puts "✅ Fixed #{fixed_files.size} YAML file(s)"
      fixed_files.each { |f| puts "  #{f}" }
    else
      puts "✅ No YAML files needed fixing"
    end
  end
end
