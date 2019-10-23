# frozen_string_literal: true

module Decidim
  module Census
    class CreateSubcensusForm < SubcensusForm

      validates :subcensus_file, presence: true

    end
  end
end
