module Decidim
  module AgeActionAuthorization
    class Authorizer < Decidim::Verifications::DefaultActionAuthorizer

      def missing_fields
        @missing_fields ||= (valid_metadata? ? [] : [:birthdate])
      end

      def unmatched_fields
        @unmatched_fields ||= (valid_age? ? [] : [:birthdate])
      end

      private

      def valid_metadata?
        return unless authorization

        !authorization.metadata['birthdate'].nil?
      end

      def valid_age?
        min_date = birthdate + minimum_age.years
        max_date = (birthdate + options['max_age'].to_i.years if options.key?('max_age'))

        if max_date
          (min_date..max_date).cover?(Date.current)
        else
          min_date <= Date.current
        end
      end

      def birthdate
        @birthdate ||= Date.strptime(authorization.metadata['birthdate'], '%Y/%m/%d')
      end

      def minimum_age
        @minimum_age ||= begin
                           Integer(options['age'].to_s, 10)
                         rescue ArgumentError
                           18
                         end
      end

    end
  end
end
