class CreateJoinTableProductCategory < ActiveRecord::Migration[5.1]
  def change
    create_join_table :products, :categories do |t|
      t.references :product, foreign_key: true, type: :uuid
      t.references :category, foreign_key: true, type: :uuid

    end
  end
end
