require 'rails_helper'

RSpec.describe 'system status page', type: :request do
<<<<<<< HEAD
  it 'returns "OK" when everything is correct' do
    FactoryGirl.create(:organization)
    get '/system_status'
    expect(response).to have_http_status(:success)
    expect(response.body).to eq('ok')
  end
=======
    it 'returns "OK" when everything is correct' do
        org = FactoryGirl.create(:organization)
        get '/system_status'
        expect(response).to have_http_status(:success)
        expect(response.body).to eq('ok')
    end
>>>>>>> 192b010c483b85c12cd6bbca475cd431d2ad8f59
end
