# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hoarder/version"

Gem::Specification.new do |s|
  s.name        = "hoarder"
  s.version     = Hoarder::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michael Cheung"]
  s.email       = ["mncheu@gmail.com"]
  s.homepage    = "http://github.com/michaelcheung/hoarder"
  s.summary     = %q{For those who can't let go of their files.}
  s.description = %q{A utility to push static files to cloud storage.}

  s.rubyforge_project = "hoarder"

  s.add_runtime_dependency "fog"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
