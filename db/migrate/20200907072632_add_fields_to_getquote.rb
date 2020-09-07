class AddFieldsToGetquote < ActiveRecord::Migration[6.0]
  def change
    add_column :getquotes, :first_name, :string
    add_column :getquotes, :last_name, :string
    add_column :getquotes, :email, :string
    add_column :getquotes, :address, :string
    add_column :getquotes, :zip, :string
    add_column :getquotes, :authorized, :boolean
    add_column :getquotes, :contractor, :boolean
    add_column :getquotes, :prefab, :boolean
    add_column :getquotes, :dev_company, :boolean
    add_column :getquotes, :location, :string
    add_column :getquotes, :new_construction, :boolean
    add_column :getquotes, :adding, :boolean
    add_column :getquotes, :remodel, :boolean
    add_column :getquotes, :complete_remodel, :boolean
    add_column :getquotes, :tenant_improvement, :boolean
    add_column :getquotes, :structural_repair, :boolean
    add_column :getquotes, :structural_eng, :boolean
    add_column :getquotes, :project_other, :string
    add_column :getquotes, :size, :string
    add_column :getquotes, :interior_alt, :boolean
    add_column :getquotes, :exterior_alt, :boolean
    add_column :getquotes, :earth_work, :boolean
    add_column :getquotes, :site_improvements, :boolean
    add_column :getquotes, :mech_elect_plumb, :boolean
    add_column :getquotes, :sewer, :boolean
    add_column :getquotes, :change_use, :boolean
    add_column :getquotes, :ccr, :string
    add_column :getquotes, :zoning, :boolean
    add_column :getquotes, :consider_environment, :boolean
    add_column :getquotes, :consider_slope, :boolean
    add_column :getquotes, :consider_other, :boolean
    add_column :getquotes, :consider_dont_know, :boolean
    add_column :getquotes, :consider_no, :boolean
  end
end
