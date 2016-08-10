class AddIdToSalePriceProducts < ActiveRecord::Migration
  def change
    add_column :spree_sale_price_products, :id, :primary_key
    add_index :spree_sale_price_products, :id, unique: true
  end
end
