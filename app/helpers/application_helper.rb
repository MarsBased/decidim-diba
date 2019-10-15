module ApplicationHelper
  def text_invalid_age_authorizer(status)
    options = status.instance_variable_get(:@authorization_handler)
                    .instance_variable_get(:@action_authorizer)
                    .instance_variable_get(:@options)
    scope = 'diba.decidim.authorization_modals.content.birthdate.invalid_field'
    min_age = options['age']
    max_age = options['max_age']

    if min_age.present? && max_age.present?
      t('both', scope: scope, max_age: max_age, min_age: min_age)
    elsif min_age.present? && max_age.blank?
      t('min_age', scope: scope, min_age: min_age)
    elsif min_age.blank? && max_age.present?
      t('max_age', scope: scope, max_age: max_age)
    end
  end
end
