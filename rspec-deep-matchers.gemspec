# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "deep-matchers"
  s.version     = Deep::Matchers::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["vitalish"]
  s.email       = ["vitalish@4life.com.ua"]
  s.homepage    = "http://github.com/vitalish/rspec-deep-matchers"
  s.summary     = %q{Deep Hash matcher for rspec}
  s.description = s.summary

  s.rubyforge_project = "rspec-deep-matchers"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rspec', '>= 2.0.0'
end
