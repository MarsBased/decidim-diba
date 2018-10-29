module Decidim
  module DibaCensusApi
    module Admin
      class ApiConfigsController < Decidim::Admin::ApplicationController

        API_AUTHORIZATIONS = %w[diba_authorization_handler
                                diba_census_api_authorization_handler].freeze
        before_action :show_instructions,
                      unless: :diba_api_authorization_active_in_organization?

        def show
          enforce_permission_to :edit, :organization, organization: current_organization

          @organization = current_organization
        end

        def edit
          enforce_permission_to :edit, :organization, organization: current_organization

          @organization = current_organization
        end

        def update
          enforce_permission_to :update, :organization, organization: current_organization

          @organization = current_organization
          @organization.update!(organization_params)
          redirect_to api_config_path, notice: t('.success')
        end

        private

        def organization_params
          params.require(:organization).permit(:diba_census_api_ine,
                                               :diba_census_api_username,
                                               :diba_census_api_password)
        end

        def show_instructions
          render :instructions
        end

        def diba_api_authorization_active_in_organization?
          (current_organization.available_authorizations & API_AUTHORIZATIONS).any?
        end

      end
    end
  end
end
