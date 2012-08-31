# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dribbble_bucket_api/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ["Ryan Townsend"]
  s.email         = ["ryan@ryantownsend.co.uk"]
  s.description   = %q{Unofficial API for browsing Dribbble buckets and their contents}
  s.summary       = s.description
  s.homepage      = "https://github.com/ryantownsend/dribbble-bucket-api"

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(spec|features)/})
  s.name          = "dribbble-bucket-api"
  s.require_paths = ["lib"]
  s.version       = DribbbleBucketApi::VERSION
  
  s.add_dependency "nokogiri"
  s.add_dependency "httparty"
  s.add_dependency "multi_json"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
end
