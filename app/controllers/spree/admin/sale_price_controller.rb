module Spree
  module Admin
    class SalePriceController < Spree::Admin::BaseController
      def index
        @sale_price = Spree::SalePrice.new
      end
    end
  end
end
