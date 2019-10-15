class Decidim::Census::SubcensusDocument < ApplicationRecord

  belongs_to :subcensus, foreign_key: :decidim_census_subcensus_id,
                         class_name: 'Decidim::Census::Subcensus'

  validates :id_document, presence: true

  private

  # Insert a collection of values
  def self.insert_documents(subcensus, values)
    return if values.blank?

    table_name = self.table_name
    columns = %w[
      id_document decidim_census_subcensus_id created_at updated_at
    ].join(',')
    now = Time.current
    values = values.map do |row|
      "('#{row[0]}', '#{subcensus.id}', '#{now}', '#{now}')"
    end
    sql = "INSERT INTO #{table_name} (#{columns}) VALUES #{values.join(',')}"
    ActiveRecord::Base.connection.execute(sql)
  end

end
