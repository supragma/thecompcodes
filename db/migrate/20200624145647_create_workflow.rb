class CreateWorkflow < ActiveRecord::Migration[6.0]
  def change
    create_table :workflows do |t|
      t.references :user
      t.references :request
      t.string :status
    end

    add_index :workflows, :status
  end
end
