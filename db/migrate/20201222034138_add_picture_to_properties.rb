class AddPictureToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :picture, :string
  end
end
