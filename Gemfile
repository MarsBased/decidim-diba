source 'https://rubygems.org'

ruby '2.5.1'

gem 'rails', '=5.2.2'

DECIDIM_VERSION = '0.15.2'

gem 'decidim', DECIDIM_VERSION
gem 'decidim-age_action_authorization', path: 'decidim-age_action_authorization'
gem 'decidim-census', path: 'decidim-census'
gem 'decidim-consultations'
gem 'decidim-diba_census_api', path: 'decidim-diba_census_api'
gem 'decidim-initiatives'
gem 'decidim-ldap', path: 'decidim-ldap'

gem 'letter_opener_web'
gem 'puma', '~> 3.10'
gem 'sidekiq'
gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'decidim-dev', DECIDIM_VERSION
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'ladle'
  gem 'pry-byebug'
  gem 'pry-coolline'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.7.0'
  gem 'rubocop', require: false
  gem 'spring-commands-rspec'
  gem 'webmock'
end

group :development do
  gem 'listen', '~> 3.1.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'
end
