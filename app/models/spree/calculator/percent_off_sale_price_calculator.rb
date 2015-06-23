module Spree
  class Calculator::PercentOffSalePriceCalculator < Spree::Calculator
    def self.description
      "Calculates the sale price for a Variant by taking off a percentage of the original price"
    end

    def compute(sale_price)
      if sale_price.value >= 1
        sale_price.value = sale_price.value.to_f/100.to_f
      end
      ((1.0 - sale_price.value.to_f) * sale_price.variant.original_price.to_f).to_d
    end
  end
end