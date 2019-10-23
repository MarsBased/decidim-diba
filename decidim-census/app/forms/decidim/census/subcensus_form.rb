# frozen_string_literal: true

module Decidim
  module Census
    class SubcensusForm < Form

      mimic :subcensus

      attribute :name, String
      attribute :participatory_process, Integer
      attribute :subcensus_file

      validates :name, :participatory_process, presence: true

      def map_model(model)
        self.participatory_process = model.decidim_participatory_process_id
      end

    end
  end
end
