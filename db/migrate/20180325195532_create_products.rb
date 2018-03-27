class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.decimal :price, precision: 15, scale: 2

      t.timestamps
    end
  end
end
