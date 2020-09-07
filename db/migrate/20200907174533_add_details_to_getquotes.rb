class AddDetailsToGetquotes < ActiveRecord::Migration[6.0]
  def change
    add_column :getquotes, :details, :string
  end
end
