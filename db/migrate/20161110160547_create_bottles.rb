class CreateBottles < ActiveRecord::Migration[5.0]
  def change
    create_table :bottles do |t|
      t.integer :vintage
      t.string :vineyard
      t.string :type
      t.string :category
      t.integer :retail_price
      t.string :appellation
      t.string :region
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
