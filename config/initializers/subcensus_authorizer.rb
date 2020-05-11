# Decidim does not allow to use more than one ActionAuthorization inside an
# AuthorizationHandler.
# This code adds an aditional validation to the AgeActionAuthorization to validate
# the subcensus.

module SubcensusAuthorizer
  def set_unmatched_fields
    errors = []
    errors << :birthdate unless valid_age?
    errors << :subcensus unless valid_subcensus?
    errors
  end

  def valid_subcensus?
    subcensus = Decidim::Census::Subcensus.find_by(
      decidim_participatory_process_id: @component&.participatory_space&.id
    )

    return true if subcensus.blank?

    Decidim::Census::SubcensusDocument.where(
      id_document: @authorization&.unique_id,
      decidim_census_subcensus_id: subcensus.id
    ).any?
  end
end

Decidim::AgeActionAuthorization::Authorizer.prepend(SubcensusAuthorizer)
