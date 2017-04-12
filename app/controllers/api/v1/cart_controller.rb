class Api::V1::CartController < Api::V1::ApiController

  before_action :set_product, except: [:edit_checkout_product_row]
  before_action :set_product_row, only: [:edit_checkout_product_row]

  def remove_cart_product_row
    ProductRow.find_by(:product => params[:product_id], :checkout_list_id => current_user.checkout_list).destroy!
    render json: {:response => 'success'}
  end

  def add_product_to_cart
    current_user.checkout_list = CheckoutList.create(:user => current_user) unless current_user.checkout_list.present?

    current_user.checkout_list.save_product_row @product
    current_user.save!

    render json: {:response => 'success'}
  end

  def edit_checkout_product_row
    render json: {:response => 'success'}
    #render json: {:response => @product_row.to_json }
  end

  private
  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

  def set_product_row
    @product_row = ProductRow.find(params[:product_row_id])
  end




end