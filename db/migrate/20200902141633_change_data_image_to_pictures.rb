class ChangeDataImageToPictures < ActiveRecord::Migration[5.2]
  def change
    change_column :pictures, :image, :text
  end
end
