Deface::Override.new(:virtual_path => "spree/admin/shared/sub_menu/_promotion",
                     :name => "admin_promotion_sub_menu_sales",
                     :insert_bottom => "[data-hook='admin_promotion_sub_tabs']",
                     :text => "<%= tab :sales, url: 'sale_promotions', icon: 'icon-th-large' %>",
                     :disabled => false)