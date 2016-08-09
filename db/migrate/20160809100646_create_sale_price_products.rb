class CreateSalePriceProducts < ActiveRecord::Migration
  def change
    create_table :spree_sale_price_products, :id => false do |t|
      t.references :sale_prices
      t.references :product
      t.timestamps
    end

    add_index :spree_sale_price_products, [:sale_prices_id, :product_id], name: "index_sale_price_with_products"
  end
end
