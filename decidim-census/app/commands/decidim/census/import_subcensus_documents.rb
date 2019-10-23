# frozen_string_literal: true

module Decidim
  module Census
    class ImportSubcensusDocuments < Rectify::Command

      def initialize(subcensus, documents_file)
        @subcensus = subcensus
        @documents_file = documents_file
      end

      def call
        return unless @documents_file.present?

        data = SubcensusCsvData.new(@documents_file.path)
        @subcensus.documents.destroy_all
        SubcensusDocument.insert_documents(@subcensus, data.values)
        broadcast(:ok, data)
      end

    end
  end
end
