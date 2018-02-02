class ChangeDatatype < ActiveRecord::Migration[5.1]
  def change
    change_column :blogs, :image, :text
    change_column :users, :image, :text
  end
end
