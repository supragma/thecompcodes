class RenameZoningToConsiderZoning < ActiveRecord::Migration[6.0]
  def change
    rename_column :getquotes, :zoning, :condsider_zoning
  end
end
