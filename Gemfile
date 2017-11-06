source 'https://rubygems.org'

ruby '2.4.0'

gem 'decidim', git: 'https://github.com/decidim/decidim.git'
gem 'sidekiq'

gem 'puma', '~> 3.0'
gem 'uglifier', '>= 1.3.0'


group :development, :test do
  gem 'byebug', platform: :mri
  gem 'decidim-dev', git: 'https://github.com/decidim/decidim.git'
  gem 'factory_girl_rails'
  gem 'faker', '~> 1.7.3'
  gem 'pry-byebug'
  gem 'pry-coolline'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'webmock'

  # Rspec with rails and spring integration
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'listen', '~> 3.1.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)
