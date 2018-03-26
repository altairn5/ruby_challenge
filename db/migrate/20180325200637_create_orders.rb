class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :customer, foreign_key: true, type: :uuid
      t.decimal :total
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
