require_relative 'lib/numbers_finder/version'

Gem::Specification.new do |spec|
  spec.name          = "numbers_finder"
  spec.version       = NumbersFinder::VERSION
  spec.authors       = ["Eugene Porodnikov"]
  spec.email         = ["questeug@gmail.com"]

  spec.summary       = %q{Finds given number of integers in big text streams}
  spec.description   = %q{Finds given number of integers in big text streams}
  spec.homepage      = "https://github.com/spr1te5/ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/spr1te5/ruby"
  spec.metadata["changelog_uri"] = "https://github.com/spr1te5/ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.2"
end
