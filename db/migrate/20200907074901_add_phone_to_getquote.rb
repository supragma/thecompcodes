class AddPhoneToGetquote < ActiveRecord::Migration[6.0]
  def change
    add_column :getquotes, :phone, :string
  end
end
