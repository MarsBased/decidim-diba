require 'net/ldap'

# rubocop:disable Metrics/BlockLength
Warden::Strategies.add(:ldap_authenticatable) do
  def authenticate!
    return unless params[:user]

    ldap_configurations.each do |ldap_configuration|
      ldap = initialize_ldap(ldap_configuration)
      ldap_entry = bind_ldap(ldap, ldap_configuration)

      next unless ldap_entry

      user = find_or_create_user(ldap_entry, ldap_configuration)
      next unless user.valid?

      return success!(user)
    end
    fail(:ldap_invalid)
  end

  private

  def initialize_ldap(ldap_configuration)
    Net::LDAP.new.tap do |ldap|
      ldap.host = ldap_configuration.host
      ldap.port = ldap_configuration.port
      ldap.base = ldap_configuration.dn
      ldap.auth(Decidim::Ldap.configuration.ldap_username,
                Decidim::Ldap.configuration.ldap_password)
    end
  end

  def bind_ldap(ldap, ldap_configuration)
    ldap.bind_as(
      base: ldap_configuration.dn,
      filter: ldap_configuration.authentication_query_for_username(username),
      password: password
    )
  end

  def username
    params[:user][:name]
  end

  def password
    params[:user][:password]
  end

  def find_or_create_user(ldap_entry, ldap_configuration)
    user = find_user(ldap_entry, ldap_configuration)
    return user if user.present?

    create_user(ldap_entry, ldap_configuration)
  end

  def find_user(ldap_entry, ldap_configuration)
    Decidim::User
      .where(email: ldap_field_value(ldap_entry, ldap_configuration.email_field))
      .or(Decidim::User.where(
            nickname: ldap_field_value(ldap_entry, ldap_configuration.username_field)
          ))
      .where(organization: ldap_configuration.organization).first
  end

  def create_user(ldap_entry, ldap_configuration)
    user = Decidim::User.new
    user.email = ldap_field_value(ldap_entry, ldap_configuration.email_field)
    user.nickname = ldap_field_value(ldap_entry, ldap_configuration.username_field)
    user.password = Devise.friendly_token.first(8)
    user.organization = ldap_configuration.organization
    user.accepted_tos_version = ldap_configuration.organization.tos_version
    user.name = ldap_field_value(ldap_entry, ldap_configuration.name_field)
    user.tos_agreement = true
    user.skip_confirmation!
    user.locale = I18n.locale
    user.save

    user
  end

  def ldap_field_value(ldap_entry, key)
    ldap_entry[0][key][0]
  end

  def ldap_configurations
    Decidim::Organization.find(params[:organization_id]).ldap_configurations
  end
end
# rubocop:enable Metrics/BlockLength
