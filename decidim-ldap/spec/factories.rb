# frozen_string_literal: true

require 'decidim/core/test/factories'

FactoryBot.define do
  factory :ldap_configuration, class: Decidim::Ldap::LdapConfiguration do
    association :organization
    host '127.0.0.1'
    port '3897'
    dn 'dc=example,dc=com'
    authentication_query 'uid=@screen_name@'
    username_field 'uid'
    email_field 'mail'
    password_field 'userPassword'
    name_field 'givenName'
  end

  factory :admin, class: Decidim::System::Admin do
    sequence(:email)      { |n| "admin#{n}@citizen.corp" }
    password              'password1234'
    password_confirmation 'password1234'
  end
end
