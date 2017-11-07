require 'rails_helper'

RSpec.describe 'system status page', type: :request do
  it 'returns "OK" when everything is correct' do
    FactoryGirl.create(:organization)
    get '/system_status'
    expect(response).to have_http_status(:success)
    expect(response.body).to eq('ok')
  end
end
