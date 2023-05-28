class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :postage, null: false
      t.integer :amount_billed, null: false
      t.integer :payment_method, null: false
      t.string :destination, null: false
      t.string :postal_code, null: false
      t.string :address_name, null: false
      t.timestamps
    end
  end
end
