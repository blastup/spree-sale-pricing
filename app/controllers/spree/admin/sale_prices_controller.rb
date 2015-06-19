module Spree
  module Admin
    class SalePricesController < BaseController

      # before_filter :load_product

      respond_to :js, :html

      def index
        @sale_price_promotions = Spree::SalePromotion.all
        @sale_prices = Spree::SalePrice.all
        @taxons = Spree::Taxon.all
      end

      def create
        @sale_prices = []
        @sale_promotion = Spree::SalePromotion.create(sale_promotion_params)
        params[:sale_promotion][:sale_price][:sale_promotion_id] = @sale_promotion.id
        params[:sale_promotion][:sale_price][:value] = @sale_promotion.value

        params[:sale_promotion][:sale_price][:taxons].each do  |taxon|

          @sale_prices = []
          @taxon = Spree::Taxon.find(taxon)
          @taxon.products.each do |product|
            @sale_price = product.put_on_sale(sale_price_params[:sale_price][:value], sale_price_params[:sale_price])

            @sale = Spree::SalePrice.last
            Spree::SalePriceTaxon.create({sale_prices_id: @sale.id, taxon_id: taxon}) if @sale
            @sale_prices << @sale_price if @sale
          end
        end
        respond_with(@sale_prices)

        # @sale_price = @product.put_on_sale params[:sale_price][:value], sale_price_params
        # respond_with(@sale_price)
      end

      def destroy
        @sale_price = Spree::SalePrice.find(params[:id])
        @sale_price.destroy
        respond_with(@sale_price)
      end

      private

      def load_product
        @product = Spree::Product.find_by(slug: params[:product_id])
        redirect_to request.referer unless @product.present?
      end

      def sale_price_params
        params.require(:sale_promotion).permit(
            :name,
            :kind,
            :value,
            :sale_price => [:id, :value, :currency, :start_at, :end_at, :enabled, :taxons, :sale_promotion_id]
        )
      end

      def sale_promotion_params
        params.require(:sale_promotion).permit(
          :name,
          :kind,
          :value
        )
      end

    end
  end
end
