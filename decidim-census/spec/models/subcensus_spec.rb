require 'spec_helper'

RSpec.describe Decidim::Census::Subcensus, type: :model do
  it { expect(FactoryBot.build(:subcensus)).to be_valid }
  it { expect(FactoryBot.build(:subcensus, participatory_process: nil)).not_to be_valid }
  it { expect(FactoryBot.build(:subcensus, name: nil)).not_to be_valid }
end
