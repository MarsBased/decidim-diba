module Decidim
  module Census
    module Admin
      class SubcensuesController < Decidim::Census::Admin::ApplicationController

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

          @form = Subcensus.new
        end

        def create
          enforce_permission_to :create, :census

          @form = Subcensus.new
          @form.attributes = subcensus_params
          if @form.save
            import_subcensus_documents(@form)
            redirect_to decidim_census_admin.subcensues_path
          else
            render :new
          end
        end

        def edit
          enforce_permission_to :create, :census

          @form = load_subcensus
        end

        def update
          enforce_permission_to :create, :census

          @form = load_subcensus
          @form.attributes = subcensus_params
          if @form.save
            import_subcensus_documents(@form)
            redirect_to decidim_census_admin.subcensues_path
          else
            render :edit
          end
        end

        def destroy
          enforce_permission_to :create, :census

          Subcensus.find(params[:id]).destroy
          redirect_to decidim_census_admin.subcensues_path, notice: t('.success')
        end

        private

        def import_subcensus_documents(subcensus)
          file_params = params.dig(:subcensus, :subcensus_file)

          return if file_params.blank?

          data = SubcensusCsvData.new(file_params.path)
          subcensus.documents.destroy_all
          SubcensusDocument.insert_documents(subcensus, data.values)
          @invalid_rows = data.errors
          flash[:notice] = t('.success', count: data.values.count,
                                         errors: data.errors.count)
        end

        def subcensus_params
          params[:subcensus].permit(:name, :decidim_participatory_process_id)
        end

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

      end
    end
  end
end
