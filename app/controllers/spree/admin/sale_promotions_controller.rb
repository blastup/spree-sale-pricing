module Spree
  module Admin
    class SalePromotionsController < BaseController

      # before_filter :load_product

      respond_to :js, :html

      def index
        @sale_prices = Spree::SalePrice.all
        @taxons = Spree::Taxon.all
        @sale_promotion = Spree::SalePromotion.new
        @sale_price_promotions = Spree::SalePromotion.all
      end

      def create
        @sale_prices = []

        if sale_promotion_params[:start_at] == ""
          sale_promotion_params[:start_at] = Time.now
        end

        @sale_promotion = Spree::SalePromotion.create(sale_promotion_params)

        # Set dos params para SalePrice
        if @sale_promotion
          set_sale_price_params
          create_sale_prices
        end

        @sale_price_promotions = Spree::SalePromotion.all
        respond_with(@sale_prices)

        # @sale_price = @product.put_on_sale params[:sale_price][:value], sale_price_params
        # respond_with(@sale_price)
      end

      def edit
        @sale_promotion = Spree::SalePromotion.find(params[:id])
        @taxons = Spree::Taxon.all
      end

      def update
        @sale_promotion = Spree::SalePromotion.find(params[:id])
        @sale_promotion.update_attributes(sale_promotion_params)

        # Zera os precos e cria novamente. Isso para garantir que se uma taxon foi removida, os produtos dela sejam tambem.
        @sale_promotion.sale_prices.destroy_all

        set_sale_price_params
        create_sale_prices

        redirect_to admin_sale_promotions_path
      end

      def destroy
        @sale_promotion = Spree::SalePromotion.find(params[:id])
        @sale_promotion.destroy
        respond_with(@sale_promotion)
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
            :taxons,
            :sale_price => [:id, :value, :currency, :start_at, :end_at, :enabled, :sale_promotion_id]
        )
      end

      def sale_promotion_params
        params.require(:sale_promotion).permit(
            :name,
            :kind,
            :value,
            :start_at,
            :end_at,
            :status,
            :taxons
        )
      end

      def set_sale_price_params
        params[:sale_promotion][:sale_price][:sale_promotion_id] = @sale_promotion.id
        params[:sale_promotion][:sale_price][:value] = @sale_promotion.value
        params[:sale_promotion][:sale_price][:start_at] = @sale_promotion.start_at
        params[:sale_promotion][:sale_price][:end_at] = @sale_promotion.end_at
        params[:sale_promotion][:sale_price][:enabled] = @sale_promotion.status
      end

      def create_sale_prices
        params[:sale_promotion][:taxons].each do  |taxon|
          @sale_prices = []
          @taxon = Spree::Taxon.find(taxon)
          @taxon.products.each do |product|
            @sale_price = product.put_on_sale(sale_price_params[:sale_price][:value], sale_price_params[:sale_price])

            @sale = Spree::SalePrice.last
            Spree::SalePriceTaxon.create({sale_prices_id: @sale.id, taxon_id: taxon}) if @sale
            @sale_prices << @sale_price if @sale
          end
        end
      end

    end
  end
end
