# frozen_string_literal: true

module Decidim
  module Census
    # Census have no public app (see AdminEngine)
    class Engine < ::Rails::Engine

      isolate_namespace Decidim::Census

      initializer 'decidim_census.add_irregular_inflection' do |_app|
        ActiveSupport::Inflector.inflections(:en) do |inflect|
          inflect.irregular 'census', 'census'
        end
      end

      initializer 'decidim_census.add_authorization_handlers' do |_app|
        Decidim::Verifications.register_workflow(:census_authorization_handler) do |auth|
          auth.form = 'CensusAuthorizationHandler'
          auth.action_authorizer = 'Decidim::AgeActionAuthorization::Authorizer'
          auth.options do |options|
            options.attribute :age, type: :string, required: false
            options.attribute :max_age, type: :string, required: false
          end
        end
      end

    end
  end
end
