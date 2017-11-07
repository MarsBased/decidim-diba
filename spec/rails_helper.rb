<<<<<<< HEAD
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
=======
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "spec_helper"
require "rspec/rails"

# Add additional requires below this line. Rails is not loaded until this point!
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
>>>>>>> 192b010c483b85c12cd6bbca475cd431d2ad8f59
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
<<<<<<< HEAD
end
=======
end
>>>>>>> 192b010c483b85c12cd6bbca475cd431d2ad8f59
