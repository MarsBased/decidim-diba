module Decidim
  module Census
    class Subcensus < ApplicationRecord

      belongs_to :participatory_process, foreign_key: :decidim_participatory_process_id,
                                         class_name: 'Decidim::ParticipatoryProcess'
      has_many :documents, class_name: 'Decidim::Census::SubcensusDocument',
                           foreign_key: :decidim_census_subcensus_id,
                           dependent: :destroy

      validates :name, presence: true

      attr_accessor :subcensus_file

    end
  end
end
