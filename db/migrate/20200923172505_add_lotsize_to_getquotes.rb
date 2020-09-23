class AddLotsizeToGetquotes < ActiveRecord::Migration[6.0]
  def change
    add_column :getquotes, :lot_size, :integer
  end
end
