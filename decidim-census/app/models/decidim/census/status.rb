module Decidim
  module Census
    # Provides information about the current status of the census data
    # for a given organization
    class Status

      def initialize(organization)
        @organization = organization
      end

      # Returns the date of the last import
      def last_import_at
        @last ||= CensusDatum.inside(@organization)
                             .order(created_at: :desc).first
        @last ? @last.created_at : nil
      end

      # Returns the number of unique census
      def count
        @count ||= CensusDatum.inside(@organization)
                              .distinct.count(:id_document)
        @count
      end

    end
  end
end
