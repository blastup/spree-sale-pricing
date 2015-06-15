module Spree
  class Calculator::FixedAmountOffSalePriceCalculator < Spree::Calculator
    
    def self.description
      "Calculates the sale price for a Variant by taking off the fixed amount of the original price"
    end

    def compute(sale_price)
      sale_price.variant.original_price - sale_price.value
    end
  end
end