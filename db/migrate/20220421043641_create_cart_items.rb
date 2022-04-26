class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      
      t.integer :amount
      t.datetime :create_at
      t.datetime :update_at
      
      t.timestamps
    end
  end
end
