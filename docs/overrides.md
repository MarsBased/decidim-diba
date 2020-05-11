## Overrides

This document lists all the overrides that have been done at the Decidim platform. Those
overrides can conflict with platform updates. During a platform upgrade they need to be compared
to the ones of the Decidim project.

The best way to spot these problems is revewing the changes in the files that are overriden
using git history and apply the changes manually.

### Controllers

**Decidim::Devise::SessionsController**

The module `Decidim::Ldap::Extensions::SessionsControllerWithLdap` is being included in the controller
to enable LDAP authentication strategy for ldap configured organizations.

**Decidim::Devise::RegistrationsController**

The module `Decidim::Ldap::Extensions::RegistrationsControllerWithLdap` is being included in the controller
to disable signup for ldap configured organizations.

### Views

**decidim-ldap/app/views/decidim/devise/sessions/new.html.erb**

It renders the [decidim-ldap/app/views/decidim/devise/sessions/_default.html.erb](/decidim-ldap/app/views/decidim/devise/sessions/_default.html.erb) or the
[decidim-ldap/app/views/decidim/devise/sessions/_ldap.html.erb](/decidim-ldap/app/views/decidim/devise/sessions/_ldap.html.erb) depending on the organization LDAP
configurations.

The _default.html partial must contain the same HTML found in the overriden new.html.erb
except for the following changes:

- The I18n keys must not be relative. They need to include the absolute route from the original file.

The _ldap.html.erb file adds the following changes:

- Replace email field for name field
- Remove signup link and social login links
- Add current organization id as a hidden field.

**decidim-ldap/app/views/decidim/shared/login_modal.html.erb**

It renders the [decidim-ldap/app/views/decidim/shared/_login_modal_default.html.erb](/decidim-ldap/app/views/decidim/shared/_login_modal_default.html.erb) or the
[decidim-ldap/app/views/decidim/shared/_login_modal_ldap.html.erb](/decidim-ldap/app/views/decidim/shared/_login_modal_ldap.html.erb) depending on the organization LDAP
configurations.

It includes the same changes found in the previous file (devise/sessions/new.html)

**decidim-ldap/app/views/layouts/decidim/_wrapper.html.erb**

It modifies the lines 76 to 78 to remove the signup link for ldap enabled organizations.

**app/views/decidim/authorization_modals/_content.html.erb**

Starting at line 26, a new behaviour has been included to show custom error messages to the custom action authorizer created for
the project.

### Helpers

**app/helpers/application_helper.rb**

This file is not overriding any Decidim behaviour, but it's using Decidim internal instance variables to be able to show custom error messages
for the decidim age action authorizer. Whenever a new upgrade is applied, it's recommended to check if the code still works as expected.

### Locales

This Decidim installation replaces the Assemblies text for Participatory committees. These
changes can be found in the following files:

- [config/locales/decidim-assemblies_ca.yml](/config/locales/decidim-assemblies_ca.yml)
- [config/locales/decidim-assemblies_en.yml](/config/locales/decidim-assemblies_en.yml)
- [config/locales/decidim-assemblies_es.yml](/config/locales/decidim-assemblies_es.yml)

Decidim changes the name of the partials from time to time, making some of the keys defined in those
files invalid.

Before upgrading the platform those keys need to be checked together with the other language files.

### Authorization & Permissions

The application has 3 custom AuthorizationHandlers. If the Decidim API for AuthorizationHandlers
changes, they need to be reviewed.

- DibaAuthorizationHandler
- CensusAuthorizationHandler
- DibaCensusApiAuthorizationHandler

Additionally, for the LDAP module adds new permissions for users. The engine is using the Decidim
Permissions system. If the Decidim permissions engine changes the following files need to be reviewed:

- [decidim-ldap/lib/decidim/ldap/extensions/controller_with_ldap_permissions.rb](/decidim-ldap/lib/decidim/ldap/extensions/controller_with_ldap_permissions.rb)
- [decidim-ldap/app/models/decidim/ldap/permissions/extra_account_permissions.rb](/decidim-ldap/app/models/decidim/ldap/permissions/extra_account_permissions.rb)


**config/initializers/subcensus_authorizer.rb**

SubcensusAuthorizer is overriding the Decidim Age Action Authorizer created for this project. As only one action authorizer can be assigned to an
AuthorizationHandler and we wanted to keep the Decidim Age Action Authorizer as an independent engine, we decided that overriding the current behaviour
was the best way to implement this feature.

It is using the Decidim internal API to be able to perform the required authorization. Whenever the project is updated this file needs to be
checked for incompatibilities.
