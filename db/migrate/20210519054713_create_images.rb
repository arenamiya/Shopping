class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.integer :ID
      t.string :image

      t.timestamps
    end
  end
end
