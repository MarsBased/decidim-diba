ENV['RAILS_ENV'] ||= 'test'

require 'pry'
require 'decidim'
require 'decidim/dev'
require 'decidim/admin'
require 'decidim/core'
require 'decidim/verifications'
require 'decidim/core/test'
require 'social-share-button'
require 'helpers'
require 'json'

RSpec.configure do |c|
  c.include Decidim::Census::Helpers
end

ENV['ENGINE_NAME'] = File.dirname(__dir__).split('/').last

Decidim::Dev.dummy_app_path =
  File.expand_path(File.join('..', 'spec', 'decidim_dummy_app'))

require 'decidim/dev/test/base_spec_helper'
