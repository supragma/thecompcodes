class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :refcode, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :getquote_id, :integer
    add_column :users, :zip, :string
  end
end
