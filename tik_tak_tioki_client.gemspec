# frozen_string_literal: true

require_relative "lib/tik_tak_tioki_client/version"

Gem::Specification.new do |spec|
  spec.name = "tik_tak_tioki_client"
  spec.version = TikTakTiokiClient::VERSION
  spec.authors = ["Christian Bäuerlein"]
  spec.email = ["hello@christianbaeuerlein.com"]

  spec.summary = "Ruby client for the TikTakTioki server"
  spec.description = "Client implementation of the API of the TikTakTioki server"
  spec.homepage = "https://ioki.enineering"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ioki-mobility"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '~> 2.0'
  spec.add_dependency 'activesupport', '~> 7.0'
end
