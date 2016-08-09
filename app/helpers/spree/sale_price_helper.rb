module Spree
	module SalePriceHelper

		def display_type kind
			if kind == 'percentage'
				Spree.t('sale_types.percentage', scope: :spree_sale_price)
			elsif kind == 'fixeddiscount'
				Spree.t('sale_types.fixeddiscount', scope: :spree_sale_price)
			elsif kind == 'fixedprice'
				Spree.t('sale_types.fixedprice', scope: :spree_sale_price)
			end
		end

		def display_discount kind, value
			if kind == 'percentage'
		 		value.to_i.to_s + ' %'
  		else
  			number_to_currency_br value
  		end
		end

		def number_to_currency_br number
  		number_to_currency number, unit: "R$ ", separator: ",", delimiter: "."
		end

		def display_datetime target
			begin
				target.strftime "%H:%M %d/%m/%Y"
			rescue
				Spree.t('unknown_date', scope: :spree_sale_price)
			end
		end

		def display_status status
			status ? Spree.t('active', scope: :spree_sale_price) : Spree.t('inactive', scope: :spree_sale_price)
		end

	end
end
