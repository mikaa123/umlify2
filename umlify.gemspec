Gem::Specification.new do |spec|
  spec.name          = "umlify"
  # spec.version       = Umlify::VERSION
  spec.authors       = ["Michael Sokol"]
  spec.email         = ["mikaa123@gmail.com"]
  spec.description   = %q{A tool to generate UML diagrams from ruby code}
  spec.summary       = %q{Generate UML diagrams from ruby code}
  spec.homepage      = "https://github.com/mikaa123/umlify2"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
