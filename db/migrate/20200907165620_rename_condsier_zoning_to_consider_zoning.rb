class RenameCondsierZoningToConsiderZoning < ActiveRecord::Migration[6.0]
  def change
    rename_column :getquotes, :condsider_zoning, :consider_zoning
  end
end
