# frozen_string_literal: true

module Decidim
  module Census
    class UpdateSubcensus < Rectify::Command

      attr_reader :form

      def initialize(subcensus, organization, form)
        @subcensus = subcensus
        @form = form
        @organization = organization
      end

      def call
        return broadcast(:invalid) if form.invalid?

        @subcensus.update_attributes!(attributes)

        events = ImportSubcensusDocuments.call(@subcensus, form.subcensus_file)
        broadcast(:ok, events[:ok])
      end

      private

      def attributes
        {
          participatory_process: find_participatory_process,
          name: form.name
        }
      end

      def find_participatory_process
        Decidim::ParticipatoryProcess.where(organization: @organization)
                                     .find(form.participatory_process)
      end

    end
  end
end
