class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :device
      t.string :imei
      t.float :yearly_price
      t.integer :installments
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
