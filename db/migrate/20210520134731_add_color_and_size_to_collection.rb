class AddColorAndSizeToCollection < ActiveRecord::Migration[5.1]
  def change
    add_column :collections, :colors, :string
    add_column :collections, :size, :string
  end
end
