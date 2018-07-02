require 'rails_helper'
require 'shared_examples/for_controllers'
require 'contexts/for_models'
require 'contexts/for_controllers'

RSpec.shared_context 'create favourites' do
	before { post :create, params: { product_id: product_id } }
end

RSpec.shared_context 'destroy favourites' do
	before { delete :destroy, params: { product_id: product_id } }
end


RSpec.describe Api::V1::FavouritesController, type: :controller do


end
