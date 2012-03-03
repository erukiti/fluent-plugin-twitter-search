# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "fluent-plugin-twitter-search"
  s.version     = "0.0.1"
  s.authors     = ["SASAKI, Shunsuke"]
  s.email       = ["erukiti@gmail.com"]
  s.homepage    = "https://github.com/erukiti/fluent-plugin-twitter-search"
  s.summary     = %q{Input filter plugin from Twitter search stream}
  s.description = %q{Input filter plugin from Twitter search stream}

  s.rubyforge_project = "fluent-plugin-twitter-search"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
