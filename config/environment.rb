# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# TODO: Move to decidim-ldap/lib/ldap/engine.erb
require 'decidim/ldap/extensions/devise_with_ldap'
Decidim::Devise::SessionsController
  .include(Decidim::Ldap::Extensions::SessionsControllerWithLdap)
Decidim::Devise::RegistrationsController
  .include(Decidim::Ldap::Extensions::RegistrationsControllerWithLdap)

# TODO: Move to decidim-ldap/lib/ldap/engine.erb
require 'decidim/ldap/extensions/controller_with_ldap_permissions'
Decidim::ApplicationController
  .prepend(Decidim::Ldap::Extensions::ControllerWithLdapPermissions)
