class AddTimeStampsToPlacement < ActiveRecord::Migration[5.1]
  def change
    add_column :placements, :created_at, :datetime, null: false
   add_column :placements, :updated_at, :datetime, null: false
  end
end
