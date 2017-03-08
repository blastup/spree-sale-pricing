Deface::Override.new(
  virtual_path: "spree/admin/products/_form",
  name: "add_sale_price",
  insert_after: "[data-hook='admin_product_form_cost_price']",
  text: "<%= render partial: 'spree/admin/sale_price/sale_price_fields', locals: { columns: false, f:f  } %>",
)

