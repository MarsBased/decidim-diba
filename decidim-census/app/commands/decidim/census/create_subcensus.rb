# frozen_string_literal: true

module Decidim
  module Census
    class CreateSubcensus < Rectify::Command

      attr_reader :form

      def initialize(organization, form)
        @organization = organization
        @form = form
      end

      def call
        return broadcast(:invalid) if form.invalid?

        subcensus = Subcensus.create!(attributes)

        events = ImportSubcensusDocuments.call(subcensus, form.subcensus_file)
        broadcast(:ok, subcensus, events[:ok])
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
