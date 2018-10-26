# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'decidim/diba_census_api/version'

Gem::Specification.new do |s|
  s.version = Decidim::DibaCensusApi::VERSION
  s.authors = ['Daniel Gómez']
  s.email = ['daniel.gomez@marsbased.com']
  s.license = 'AGPL-3.0'
  s.homepage = 'https://github.com/MarsBased/decidim-diba'
  s.required_ruby_version = '>= 2.3.1'

  s.name = 'decidim-diba_census_api'
  s.summary = 'AuthorizationHandler provider against the Diputació of Barcelona Census API'
  s.description = s.summary

  s.files = Dir['{app,config,db,lib,vendor}/**/*', 'Rakefile', 'README.md']

  s.add_dependency 'decidim', s.version
  s.add_dependency 'decidim-age_action_authorization', s.version
  s.add_dependency 'decidim-core', s.version

  s.add_dependency 'savon', '~> 2.11.2'
  s.add_dependency 'virtus-multiparams', '~> 0.1.1'

  s.add_development_dependency 'decidim-dev', s.version
  s.add_development_dependency 'faker'
end
