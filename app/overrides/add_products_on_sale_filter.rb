Deface::Override.new(
  virtual_path: "spree/admin/products/new",
  name: "add_sale_price",
  insert_bottom: "[data-hook='admin_products_index_search']",
  text: " <div class='field checkbox'>
          <label>
            <%= f.check_box :discontinue_on_null, {checked: params[:q][:discontinue_on_null] == '0'}, '0', '1' %>
            <%= Spree.t(:show_discontinued ) %>
          </label>
        </div>",
)