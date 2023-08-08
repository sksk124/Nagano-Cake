class AddTotalItemsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :total_items, :integer
  end
end
