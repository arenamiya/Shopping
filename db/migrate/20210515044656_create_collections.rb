class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.string :name
      t.string :category
      t.decimal :price
      t.date :stockdate
      t.string :photo

      t.timestamps
    end
  end
end
