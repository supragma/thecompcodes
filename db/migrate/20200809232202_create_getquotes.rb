class CreateGetquotes < ActiveRecord::Migration[6.0]
  def change
    create_table :getquotes do |t|
      t.string :json_blob

      t.timestamps
    end
  end
end
