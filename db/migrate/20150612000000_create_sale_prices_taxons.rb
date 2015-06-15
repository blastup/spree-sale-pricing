class CreateSalePricesTaxons < ActiveRecord::Migration
  def change

    create_table :spree_sale_prices_taxons, :id => false do |t|
      t.references :sale_prices
      t.references :taxon
      t.timestamps
    end

    add_index :spree_sale_prices_taxons, [:sale_prices_id, :taxon_id], name: "index_sale_prices_with_taxons"
  end
end
