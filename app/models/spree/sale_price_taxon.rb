module Spree
  class SalePriceTaxon < Spree::Base
    belongs_to :sale_price
    belongs_to :taxon
  end
end