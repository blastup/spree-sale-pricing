Spree::Admin::ProductsController.class_eval do
  create.after :create_after

  def new
    @sale_price = Spree::SalePrice.new
    super
  end

  def edit
    @sale_price = @product.master.sale_prices.first
    @sale_price = Spree::SalePrice.new unless @sale_price
    super
  end

  def create
    params.delete(:sale_price)
    super
  end

  def update
    cache_sale_price_attributes
    put_on_sale unless @sale_price_attributes.nil?
    super
  end

  def create_after
    put_on_sale
    return if @sale_price_attributes.nil? || @sale_price_attributes[:value].blank?
  end

  def create_before
    cache_sale_price_attributes
    return if params[:product][:prototype_id].blank?
    @prototype = Spree::Prototype.find(params[:product][:prototype_id])
  end

  private

    def cache_sale_price_attributes
      @sale_price_attributes = params[:product].delete :sale_price
    end

    def put_on_sale
      @product.put_on_sale @sale_price_attributes[:value].to_f, {
                                                                kind: @sale_price_attributes[:kind], 
                                                                start_at: @sale_price_attributes[:start_at],
                                                                end_at: @sale_price_attributes[:end_at]}     
    end
end