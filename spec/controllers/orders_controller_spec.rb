require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  include ApplicationHelper

  let!(:order) { create(:order) }

  describe 'GET tracking page for user Order' do
	 login_user

	 before {
		get :tracking, :tracking_code => order.code
	 }

	 it { expect(response.status).to eq 200 }
	 it { expect(response.content_type).to eq('text/html') }

	 it 'renders the tracking order template' do
		expect(response).to render_template('tracking')
	 end

  end


  describe 'GET tracking page for non existing order' do
	 it 'redirects user to the cart' do
		get :tracking, :tracking_code => 'A$FAKE%CODE'
		expect(response).to redirect_to(cart_path)
	 end
  end



end
