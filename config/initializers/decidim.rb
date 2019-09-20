# frozen_string_literal: true

require 'extensions/workflow_manifest_extension'

Decidim.configure do |config|
  config.application_name = 'Decidim DIBA'
  config.mailer_sender    = 'decidim@diba.cat'

  # Reset default workflows
  Decidim::Verifications.clear_workflows

  Decidim::Verifications.register_workflow(:diba_authorization_handler) do |auth|
    auth.form = 'DibaAuthorizationHandler'
    auth.action_authorizer = 'Decidim::AgeActionAuthorization::Authorizer'
    auth.options do |options|
      options.attribute :age, type: :string, required: false
      options.attribute :max_age, type: :string, required: false
    end
  end

  Decidim::Verifications::WorkflowManifest.prepend(WorkflowManifestExtension)

  # Uncomment this lines to set your preferred locales
  config.available_locales = %i(ca es en)

  # Geocoder configuration
  geocoder_config = Rails.application.secrets.geocoder
  if geocoder_config[:here_app_id].present? && geocoder_config[:here_app_code].present?
    config.geocoder = {
      here_app_id: geocoder_config[:here_app_id],
      here_app_code: geocoder_config[:here_app_code]
    }
  end
end

Decidim::Ldap.configure do |config|
  config.ldap_username = Rails.application.secrets.ldap[:username]
  config.ldap_password = Rails.application.secrets.ldap[:password]
end
