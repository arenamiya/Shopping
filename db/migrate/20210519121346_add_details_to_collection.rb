class AddDetailsToCollection < ActiveRecord::Migration[5.1]
  def change
    add_column :collections, :details, :string
  end
end
