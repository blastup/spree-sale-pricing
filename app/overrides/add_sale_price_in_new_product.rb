Deface::Override.new(
  virtual_path: "spree/admin/products/new",
  name: "add_sale_price",
  insert_after: "[data-hook='product-from-prototype']",
  text: "<%= render partial: 'spree/admin/sale_price/sale_price_fields', locals: { columns: true, f: f  } %>",
)

