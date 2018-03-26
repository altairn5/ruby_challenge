class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :customer, foreign_key: true, type: :uuid
      t.decimal :total, precision: 15, scale: 2
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
