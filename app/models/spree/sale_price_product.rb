module Spree
  class SalePriceProduct < Spree::Base
    belongs_to :sale_price, :class_name => 'Spree::SalePrice', :foreign_key => 'sale_prices_id'
    belongs_to :product
  end
end
