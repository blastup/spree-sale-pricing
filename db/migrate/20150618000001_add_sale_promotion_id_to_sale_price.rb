class AddSalePromotionIdToSalePrice < ActiveRecord::Migration
  def change
    add_column :spree_sale_prices, :sale_promotion_id, :integer
    add_index :spree_sale_prices, :sale_promotion_id
  end
end