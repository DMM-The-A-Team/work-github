class AddIsDeletedToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :is_deleted, :boolean
  end

  def change
    add_column :customers, :is_deleted, :boolean, default: false
  end

end
