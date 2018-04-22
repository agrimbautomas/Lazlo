class ProductsController < ApplicationController

  before_action :set_request, :set_product, :set_meta_data, :set_product_hash

  def show
	 set_purchase_link unless current_user.nil?
	 @is_in_cart = (current_user.has_product_in_cart?(@product) ? true : false) unless current_user.nil?
  end

  def set_request
	 $request = request
  end

  private
  def set_product
	 @product = Product.friendly.find(params[:id])
	 @suggestions = Product.suggestions_for(@product)
	 @product.update_attribute(:views, @product.views + 1)
  end

  def set_meta_data
	 set_og_tags @product.name,
					 @product.description.squish,
					 resource_absolute_path(@product.image.url(:medium))
  end

  def set_purchase_link
	 params[:user] = current_user
	 params[:product] = @product
	 @product_link = MercadoPagoSingleCheckout.(parameters: params, delegate: self).checkout
  end

  def set_product_hash
	 @product_hash = {
		  :product_id => @product.id,
		  :version => Rails.application.config.API_VERSION
	 }
  end

end
