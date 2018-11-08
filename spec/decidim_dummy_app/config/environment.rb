# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

require 'decidim/ldap/extensions/devise_with_ldap'
Decidim::Devise::SessionsController
  .include(Decidim::Ldap::Extensions::SessionsControllerWithLdap)
Decidim::Devise::RegistrationsController
  .include(Decidim::Ldap::Extensions::RegistrationsControllerWithLdap)
