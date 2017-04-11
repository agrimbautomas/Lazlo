class Api::V1::CartController < Api::V1::ApiController

  before_action :set_product

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

  #Pending - Add favourites
  def add_product_to_wish_list
    current_user.favourites_list = FavouritesList.create(:user => current_user) unless current_user.favourites_list.present?

    current_user.favourites_list.save_product_row @product
    current_user.save!

    render json: {:response => 'success'}
  end


  private
  def set_product
    @product = Product.friendly.find(params[:product_id])
  end


end