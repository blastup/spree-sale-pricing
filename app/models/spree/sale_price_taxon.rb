module Spree
  class SalePriceTaxon < Spree::Base
    belongs_to :sale_price, :class_name => 'Spree::SalePrice', :foreign_key => 'sale_prices_id'
    belongs_to :taxon
  end
end