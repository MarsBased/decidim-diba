module Decidim
  module Census
    module Admin
      class SubcensusesController < Decidim::Census::Admin::ApplicationController

        include Rectify::ControllerHelpers

        CENSUS_AUTHORIZATIONS = %w[diba_authorization_handler
                                   census_authorization_handler].freeze

        before_action :show_instructions,
                      unless: :census_authorization_active_in_organization?
        helper_method :query, :subcensuses, :participatory_processes

        def index
          enforce_permission_to :create, :census
        end

        def new
          enforce_permission_to :create, :census

          @form = form(CreateSubcensusForm).instance
        end

        def create
          enforce_permission_to :create, :census

          @form = form(CreateSubcensusForm).from_params(params)

          CreateSubcensus.call(current_organization, @form) do
            on(:ok) do |_subcensus, imported_data|
              configure_flash_for(imported_data)
              redirect_to decidim_census_admin.subcensuses_path
            end

            on(:invalid) { render :new }
          end
        end

        def edit
          enforce_permission_to :create, :census

          @form = form(SubcensusForm).from_model(load_subcensus)
        end

        def update
          enforce_permission_to :create, :census

          @form = form(SubcensusForm).from_params(params)

          UpdateSubcensus.call(load_subcensus, current_organization, @form) do
            on(:ok) do |imported_data|
              configure_flash_for(imported_data)
              redirect_to decidim_census_admin.subcensuses_path
            end

            on(:invalid) { render :edit }
          end
        end

        def destroy
          enforce_permission_to :create, :census

          Subcensus.find(params[:id]).destroy
          redirect_to decidim_census_admin.subcensuses_path, notice: t('.success')
        end

        private

        def subcensuses
          @subcensuses ||= query.result(distinct: true)
        end

        def query
          @query ||= subcensuses_scope.ransack(params[:q])
        end

        def subcensuses_scope
          @subcensuses_scope ||= Decidim::Census::Subcensus.where(
            decidim_participatory_process_id: participatory_processes
          )
        end

        def participatory_processes
          @participatory_processes ||=
            ParticipatoryProcesses::OrganizationParticipatoryProcesses
            .new(current_organization).query
        end

        def load_subcensus
          Decidim::Census::Subcensus.find(params[:id])
        end

        def census_authorization_active_in_organization?
          (current_organization.available_authorizations & CENSUS_AUTHORIZATIONS).any?
        end

        def configure_flash_for(imported_data)
          return unless imported_data

          flash[:notice] = t('.success', count: imported_data.values.count,
                                         errors: imported_data.errors.count)
          expose(invalid_rows: imported_data.errors)
        end

      end
    end
  end
end
