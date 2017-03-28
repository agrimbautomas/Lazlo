class Api::V1::CartController < Api::V1::ApiController

  before_action :set_product, only: [:add_product_to_wish_list, :remove_product_row]

  def remove_product_row
    ProductRow.find_by(:product => params[:product_id], :favourites_list_id => current_user.favourites_list).destroy!
    render json: {:response => 'success'}
  end

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