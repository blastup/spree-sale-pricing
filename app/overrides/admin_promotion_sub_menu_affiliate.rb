Deface::Override.new(:virtual_path => "spree/admin/shared/sub_menu/_promotion",
                     :name => "admin_promotion_sub_menu_affiliates",
                     :insert_top => "[data-hook='admin_promotion_sub_tabs']",
                     :text => "<%= tab :affiliates, url: 'affiliates', icon: 'icon-th-large' %>",
                     :disabled => false)