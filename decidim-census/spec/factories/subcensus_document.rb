FactoryBot.define do
  factory :subcensus_document, class: Decidim::Census::SubcensusDocument do
    id_document { '123456789A' }
    subcensus
  end
end
