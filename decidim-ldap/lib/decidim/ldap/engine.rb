# frozen_string_literal: true

require 'rails'
require 'active_support/all'

require 'decidim/ldap/extensions/devise_with_ldap'
require 'decidim/ldap/extensions/organization_with_ldap'

module Decidim
  module Ldap
    class Engine < ::Rails::Engine

      isolate_namespace Decidim::Ldap

      routes do
        authenticate(:admin) do
          resources :ldap_configurations
        end
      end

      initializer 'decidim_ldap.mount_routes' do
        Decidim::Core::Engine.routes do
          mount Decidim::Ldap::Engine => '/system'
        end
      end

      initializer 'decidim_ldap.authentication_strategy' do
        require 'decidim/ldap/extensions/authentication_strategy'
      end

      initializer 'decidim_ldap.menu' do
        Decidim.menu :system_menu do |menu|
          menu.item I18n.t('menu.ldap', scope: 'decidim.ldap'),
                    decidim_ldap.ldap_configurations_path,
                    position: 2,
                    active: :inclusive
        end
      end

      initializer 'decidim_ldap.devise_with_ldap' do
        Decidim::Devise::SessionsController
          .include(Decidim::Ldap::Extensions::SessionsControllerWithLdap)
        Decidim::Devise::RegistrationsController
          .include(Decidim::Ldap::Extensions::RegistrationsControllerWithLdap)
      end

      initializer 'decidim_ldap.organization_with_ldap' do
        config.to_prepare do
          Decidim::Organization.include Decidim::Ldap::Extensions::OrganizationWithLdap
        end
      end

      initializer 'decidim_ldap.add_ldap_account_authorizations' do |_app|
        Decidim.configure do |config|
          config.abilities += ['Decidim::Ldap::Abilities::CurrentUserAbility']
        end
      end

    end
  end
end
