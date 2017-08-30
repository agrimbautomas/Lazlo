class SaveAdminOrder < Interactor

  def initialize(arguments)
	 super
	 @order = arguments.fetch :order
	 @order_params = arguments.fetch :order_params
	 @order_products_rows = @order.order_products_list.order_products_rows
  end

  def update_order
	 set_products_to_list
	 set_new_order_values
	 @order
  end

  private

  def set_products_to_list
	 order_products_params.each do |product_row_params|
		if old_product_row(product_row_params).present?
		  old_product_row(product_row_params).update(:quantity => product_row_params['quantity'])
		else
		  @order_products_rows << OrderProductsRow.create(product_row_params)
		end
	 end
  end

  def set_new_order_values
	 @order.buyer_id = @order_params[:buyer_id] unless @order_params[:buyer_id].empty?
	 @order.user_id = @order_params[:user_id] unless @order_params[:user_id].empty?
	 @order.detail = @order_params[:detail] unless @order_params[:detail].empty?
	 @order.order_status_id = @order_params[:order_status_id] unless @order_params[:order_status_id].empty?
	 @order.title = @order_params[:title] unless @order_params[:title].empty?
	 @order.payment = @order_params[:payment] unless @order_params[:payment].empty?
	 @order.save!
  end

  def order_products_params
	 @order_params.require(:order_products_rows_attributes) unless @order_params[:order_products_rows_attributes].nil?
  end

  def old_product_row params
	 @order_products_rows.find { |s| s.product_id == params['product_id'].to_i }
  end

end