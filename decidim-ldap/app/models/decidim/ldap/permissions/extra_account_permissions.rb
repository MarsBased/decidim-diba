# frozen_string_literal: true

module Decidim
  module Ldap
    module Permissions
      class ExtraAccountPermissions < Decidim::DefaultPermissions

        def permissions
          return permission_action if permission_action.subject != :user
          return permission_action if permission_action.action != :delete

          disallow! if context[:current_organization].ldap?

          permission_action
        end

      end
    end
  end
end
