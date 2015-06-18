class CreateSalePromotions < ActiveRecord::Migration
  def change
    create_table :spree_sale_promotions do |t|

      t.string :name
      t.string :kind
      t.decimal :value, precision: 10, scale: 2, null: false
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
