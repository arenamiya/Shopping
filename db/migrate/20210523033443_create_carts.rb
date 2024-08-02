class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.string :user
      t.string :size
      t.string :color
      t.integer :quantity

      t.timestamps
    end
  end
end
