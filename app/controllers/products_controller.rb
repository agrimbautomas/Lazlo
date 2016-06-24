class ProductsController < ApplicationController
  def index
  end

  def show


    @table = Product.find(params[:id])
    preference_data = {
        "items" => [
            "title" => @table.name,
            "quantity" => 1,
            "unit_price" => @table.price,
            "currency_id" => "ARS",
            "picture_url" => @table.image.url(:medium)
        ]}

    @preference = $mp_client.create_preference(preference_data)

  end

  def tables
    @tables = Product.all
  end
end
