require File.expand_path('../lib/foretello_api_v21/version', __FILE__)
require 'date'

Gem::Specification.new do |s|
  s.name        = "foretello_api_v21"
  s.version     = ForetelloApiV21::VERSION
  s.date        = Date.today.to_s
  s.authors     = ["Joseph Magen"]
  s.email       = ["jmagen@redhat.com"]
  s.homepage    = "http://www.theforeman.org"
  s.summary     = "Plugin engine to that adds v21 API for Foreman and Katello based on jsonapi.org spec."
  s.description = "Plugin engine to that adds v21 API for Foreman and Katello based on jsonapi.org spec."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "active_model_serializers", '~> 0.9.3'
  #s.add_dependency "apipie-rails"

end
