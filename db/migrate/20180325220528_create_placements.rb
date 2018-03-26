class CreatePlacements < ActiveRecord::Migration[5.1]
  def change
    create_table :placements, id: :uuid do |t|
      t.references :order, foreign_key: true, type: :uuid
      t.references :product, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
