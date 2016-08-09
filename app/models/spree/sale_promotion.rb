module Spree
  class SalePromotion < ActiveRecord::Base

    has_many :sale_prices, dependent: :destroy

    has_many :taxons, through: :sale_prices
    has_many :products, through: :sale_prices

    accepts_nested_attributes_for :sale_prices

    before_save :set_start_at

    validates :value, presence: true, numericality: true
    validates :name, presence: true

    def set_start_at
      self.start_at = Time.now unless self.start_at
    end

  end
end
