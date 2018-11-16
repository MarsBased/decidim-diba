# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/BlockLength
describe 'Manage Ldap Configurations', type: :system do
  let(:admin) { FactoryBot.create(:admin) }

  before do
    login_as admin, scope: :admin
  end

  it 'creates a new LDAP Configuration' do
    organization = FactoryBot.create(:organization)

    visit decidim_ldap.ldap_configurations_path
    find('.actions .new').click

    within '.new_ldap_configuration' do
      select organization.name, from: 'ldap_configuration_organization'
      fill_in :ldap_configuration_host, with: '127.0.0.1'
      fill_in :ldap_configuration_port, with: '389'
      fill_in :ldap_configuration_dn, with: 'ou=people,dc=example,dc=com'
      fill_in :ldap_configuration_authentication_query,
              with: 'uid=@screen_name@,ou=people,dc=example,dc=com'
      fill_in :ldap_configuration_username_field, with: 'uid'
      fill_in :ldap_configuration_email_field, with: 'mail'
      fill_in :ldap_configuration_password_field, with: 'userPassword'
      fill_in :ldap_configuration_name_field, with: 'givenName'

      find('*[type=submit]').click
    end

    within '.flash' do
      expect(page).to have_content('successfully')
    end

    within 'table' do
      expect(page).to have_content('ou=people,dc=example,dc=com')
    end
  end

  it 'updates an LDAP Configuration' do
    organization = FactoryBot.create(:organization)
    ldap_configuration =
      FactoryBot.create(:ldap_configuration, organization: organization)

    visit decidim_ldap.ldap_configurations_path

    within find('tr', text: ldap_configuration.dn) do
      click_link 'Edit'
    end

    within '.edit_ldap_configuration' do
      fill_in :ldap_configuration_dn, with: 'new_dn'

      find('*[type=submit]').click
    end

    within '.flash' do
      expect(page).to have_content('successfully')
    end

    within 'table' do
      expect(page).to have_content('new_dn')
    end
  end

  it 'deletes an LDAP Configuration' do
    organization = FactoryBot.create(:organization)
    ldap_configuration =
      FactoryBot.create(:ldap_configuration, organization: organization)

    visit decidim_ldap.ldap_configurations_path

    within find('tr', text: ldap_configuration.dn) do
      accept_alert do
        click_link 'Delete'
      end
    end

    within '.flash' do
      expect(page).to have_content('successfully')
    end

    within 'table' do
      expect(page).not_to have_content(ldap_configuration.dn)
    end
  end
end
