# frozen_string_literal: true

require_relative 'lib/bdd_openai/version'

Gem::Specification.new do |spec|
  spec.name = 'bdd_openai'
  spec.version = BddOpenai::VERSION
  spec.authors = ['Brendon Dao']
  spec.email = ['brendon.dao@employmenthero.com']
  spec.metadata['source_code_uri'] = 'https://github.com/brendondaoateh/bdd_openai'
  spec.summary = 'Write a short summary, because RubyGems requires one.'
  spec.description = 'Write a longer description or delete this line.'

  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  # spec.metadata["allowed_push_host"] = "Set to your gem server 'https://example.com'"

  spec.homepage = spec.metadata['source_code_uri']
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/brendondaoateh/bdd_openai/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
