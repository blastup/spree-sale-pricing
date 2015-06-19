class AddIdToSalePriceTaxons < ActiveRecord::Migration
  def change
    add_column :spree_sale_price_taxons, :id, :primary_key
    add_index :spree_sale_price_taxons, :id, unique: true
  end
end