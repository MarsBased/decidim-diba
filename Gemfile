source 'https://rubygems.org'

ruby '2.4.0'

gem 'decidim', git: 'https://github.com/decidim/decidim.git'
gem 'sidekiq'

gem 'puma', '~> 3.0'
gem 'uglifier', '>= 1.3.0'


group :development, :test do
  gem 'decidim-dev', git: 'https://github.com/decidim/decidim.git'
  gem 'byebug', platform: :mri
  gem 'pry-byebug'
  gem 'pry-coolline'
  gem 'pry-rails'
  gem 'factory_girl_rails'
  gem 'faker', '~> 1.7.3'
  gem 'webmock'

  # Rspec with rails and spring integration
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.1.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
