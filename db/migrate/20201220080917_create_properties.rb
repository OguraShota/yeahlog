class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.text :reference
      t.integer :recommend
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :properties, [:user_id, :created_at]
  end
end
