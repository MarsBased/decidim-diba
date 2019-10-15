class CreateDecidimCensusSubcensus < ActiveRecord::Migration[5.2]

  def change
    create_table :decidim_census_subcensus do |t|
      t.references :decidim_participatory_process, index: { name: 'index_decidim_census_subcensuses_on_participatory_process_id' }
      t.string :name

      t.timestamps
    end
  end

end
