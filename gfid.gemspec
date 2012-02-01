# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gfid/version"

Gem::Specification.new do |s|
  s.name        = "gfid"
  s.version     = Gfid::VERSION
  s.authors     = ["pochi.black"]
  s.email       = ["pochi.black@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{gem fetch --include-dependencies}
  s.description = %q{This gems make you can 'gem fetch --include-dependencies'}

  s.rubyforge_project = "gfid"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
