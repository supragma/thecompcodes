class CreatePasswordResets < ActiveRecord::Migration[6.0]
  def change
    create_table :password_resets do |t|
      t.integer :user_id
      t.string :token
      t.datetime :token_expiration
      t.boolean :is_used

      t.timestamps
    end

    change_column_default :password_resets, :is_used, false

  end
end
