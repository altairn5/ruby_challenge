class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers, id: :uuid do |t|
      t.citext :email
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :password_digest

      t.timestamps
    end
  end
end
