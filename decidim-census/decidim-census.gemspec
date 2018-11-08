$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'decidim/census/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'decidim-census'
  s.version     = Decidim::Census::VERSION
  s.authors     = ['Daniel Gómez']
  s.email       = ['daniel.gomez@marsbased.com']
  s.summary     = 'Census support for Decidim Diputació de Barcelona'
  s.description = 'Census uploads via csv files and API integration'
  s.homepage    = 'https://github.com/marsbased/'
  s.license     = 'AGPLv3'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'decidim', s.version
  s.add_dependency 'decidim-admin', s.version
  s.add_dependency 'decidim-age_action_authorization'
  s.add_dependency 'decidim-ldap', s.version
  s.add_dependency 'virtus-multiparams', '~> 0.1.1'

  s.add_development_dependency 'decidim-dev', s.version
  s.add_development_dependency 'faker'
end
