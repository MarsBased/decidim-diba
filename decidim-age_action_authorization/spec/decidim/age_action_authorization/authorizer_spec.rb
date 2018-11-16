require 'spec_helper'

RSpec.describe Decidim::AgeActionAuthorization::Authorizer do
  let(:authorizer_class) { Decidim::AgeActionAuthorization::Authorizer }

  it 'authorizes with age metadata' do
    authorizer = authorizer_class.new(authorization_for('1970/11/21'), { age: '20' }, double('component'))
    expect(authorizer.authorize).to include(:ok)
  end

  it 'uses 18 as default age when not present' do
    old = 18.years.ago.strftime('%Y/%m/%d')
    auth_old = authorizer_class.new(authorization_for(old), { age: nil }, double('component'))
    expect(auth_old.authorize).to include(:ok)

    young = 17.years.ago.strftime('%Y/%m/%d')
    auth_young = authorizer_class.new(authorization_for(young), { age: nil }, double('component'))
    expect(auth_young.authorize).to eq([:unauthorized, { fields: [:birthdate] }])
  end

  it 'does not authorize the user if the authorization is not present' do
    authorizer_without_authorization = authorizer_class.new(nil, { age: nil }, double('component'))

    expect(authorizer_without_authorization.authorize).to include(:missing)
  end

  def authorization_for(date)
    OpenStruct.new(metadata: { 'birthdate' => date },
                   granted?: true)
  end
end
