module Spree
  class SalePromotion < ActiveRecord::Base

    has_many :sale_prices, dependent: :destroy

    has_many :taxons, through: :sale_prices

    accepts_nested_attributes_for :sale_prices

    attr_accessor :taxons_ids

    after_save :touch_all_prices

    def touch_all_prices

    end

  end
end