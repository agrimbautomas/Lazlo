class  Api::V1::ApiController < ActionController::Base
  #version 1

  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_action :authenticate_user!

  def purchase_product_data
    @table = Product.friendly.find(params[:product_id])

    @table.set_quantity ( params[:quantity].present? ? params[:quantity].to_i : 1)

    expose @table.payment
  end

end
