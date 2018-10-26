$:.push File.expand_path('../lib', __FILE__)

require 'decidim/age_action_authorization/version'

Gem::Specification.new do |s|
  s.name        = 'decidim-age_action_authorization'
  s.version     = Decidim::AgeActionAuthorization::VERSION
  s.authors     = ['Xavier Redó']
  s.email       = ['xavier.redo@marsbased.com']
  s.summary     = 'Age Based Action authorizer for the Decidim project'
  s.description = ''
  s.homepage    = 'https://github.com/marsbased/'
  s.license     = 'AGPLv3'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'decidim', Decidim::AgeActionAuthorization::VERSION

  s.add_development_dependency 'decidim-dev', Decidim::AgeActionAuthorization::VERSION
end
