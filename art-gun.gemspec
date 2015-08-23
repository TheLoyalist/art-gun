# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'art_gun/version'

Gem::Specification.new do |spec|
  spec.name          = "art-gun"
  spec.version       = ArtGun::VERSION
  spec.authors       = ["Lars Kluge"]
  spec.email         = ["l@larskluge.com"]

  spec.summary       = %q{Ruby wrapper for Art-Gun's API}
  spec.description   = %q{A Ruby wrapper to access Art-Gun's API.}
  spec.homepage      = "https://github.com/larskluge/art-gun"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activemodel', '~> 4.2'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "dotenv", "~> 2.0"
end
