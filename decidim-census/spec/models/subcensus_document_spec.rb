require 'spec_helper'

RSpec.describe Decidim::Census::SubcensusDocument, type: :model do
  it { expect(FactoryBot.build(:subcensus_document)).to be_valid }
  it { expect(FactoryBot.build(:subcensus_document, id_document: nil)).not_to be_valid }
  it { expect(FactoryBot.build(:subcensus_document, subcensus: nil)).not_to be_valid }
end
