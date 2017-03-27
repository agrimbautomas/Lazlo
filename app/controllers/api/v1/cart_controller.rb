class Api::V1::CartController < Api::V1::ApiController

  def remove_product_row
    ProductRow.find(params[:product_row_id]).destroy!
    render json: {:response => 'success'}
  end




end