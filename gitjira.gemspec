# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitjira/version'

Gem::Specification.new do |spec|
  spec.name          = "gitjira"
  spec.version       = Gitjira::VERSION
  spec.authors       = ["Alex Oberhauser"]
  spec.email         = ["alex.oberhauser@sigimera.org"]
  spec.description   = %q{Git JIRA is an extension that combines feature or all other type of branches with JIRA issues. It shows the current status and the summary of the issue.}
  spec.summary       = %q{A git extension that combines feature branches with JIRA issues.}
  spec.homepage      = "https://github.com/Sigimera/gitjira"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 1.6"
  spec.add_dependency "highline"
  spec.add_dependency "parseconfig"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
