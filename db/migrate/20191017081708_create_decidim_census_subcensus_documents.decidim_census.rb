# This migration comes from decidim_census (originally 20191009140338)
class CreateDecidimCensusSubcensusDocuments < ActiveRecord::Migration[5.2]

  def change
    create_table :decidim_census_subcensus_documents do |t|
      t.references :decidim_census_subcensus, index: { name: 'index_census_subcensus_documents_on_census_subcensus_id' }
      t.string :id_document

      t.timestamps
    end
  end

end
