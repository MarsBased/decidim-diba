# frozen_string_literal: true

require 'spec_helper'
require 'ladle'

# rubocop:disable Metrics/BlockLength
describe 'When LDAP authentication is active', type: :system do
  let(:organization) { FactoryBot.create(:organization, :with_tos) }
  let(:ldap_configuration) do
    FactoryBot.create(:ldap_configuration, organization: organization)
  end

  before do
    Decidim::Ldap.configuration.ldap_username = 'uid=admin,ou=people,dc=example,dc=com'
    Decidim::Ldap.configuration.ldap_password = 'password1234'

    @ldap_server =
      Ladle::Server.new(quiet: true,
                        ldif: 'lib/ladle/default.ldif',
                        domain: ldap_configuration.dn,
                        host: ldap_configuration.host,
                        port: ldap_configuration.port).start
    switch_to_host(organization.host)
    visit decidim.root_path
  end

  after do
    @ldap_server&.stop
    Decidim::Ldap.configuration.ldap_username = nil
    Decidim::Ldap.configuration.ldap_username = nil
  end

  it 'hides signup link' do
    expect(page).to_not have_css('.sign-up-link')
  end

  it 'creates a session when correct credentials are provided' do
    click_link 'Sign In'

    within '.new_user' do
      fill_in :user_name, with: 'Alice'
      fill_in :user_password, with: 'password1234'

      find('*[type=submit]').click
    end

    within '.flash' do
      expect(page).to have_content('successfully')
    end
  end

  it 'fails to create a session with incorrect credentials' do
    click_link 'Sign In'

    within '.new_user' do
      fill_in :user_name, with: 'Fail'
      fill_in :user_password, with: 'password1234'

      find('*[type=submit]').click
    end

    within '.flash' do
      expect(page).to have_content('Invalid username or password')
    end
  end

  describe 'and there is more than one LDAP configuration' do
    let!(:second_ldap_configuration) do
      FactoryBot.create(:ldap_configuration,
                        organization: organization,
                        authentication_query: 'mail=@screen_name@')
    end

    it 'creates a session using the correct LDAP configuration' do
      click_link 'Sign In'

      within '.new_user' do
        fill_in :user_name, with: 'max@payne.com'
        fill_in :user_password, with: 'password1234'

        find('*[type=submit]').click
      end

      within '.flash' do
        expect(page).to have_content('successfully')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
