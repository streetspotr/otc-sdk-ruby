# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "otc/version"

Gem::Specification.new do |spec|
  spec.name          = "otc-sdk-ruby"
  spec.version       = Otc::VERSION
  spec.authors       = ["Streetspotr GmbH"]
  spec.email         = ["devs@streetspotr.com"]

  spec.summary       = %q{Ruby SDK which wraps the open telekom cloud API}
  spec.homepage      = "https://github.com/streetspotr/otc-sdk-ruby"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.0"
end
