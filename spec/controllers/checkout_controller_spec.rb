require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
	include MercadoPagoHelper


	let(:user) { create(:user_with_checkout_list) }
	let!(:product) { create(:product) }

	before {
		params = ActionController::Parameters.new
		params[:user] = user
	}

	describe 'GET single_checkout_success ' do
		login_user

		before {
			mp_params = mercado_pago_params(user, product)
			get :single_checkout_success,
				params: {
					:collection_id => mp_params[:collection_id],
					:preference_id => mp_params[:preference_id],
					:payment_type => mp_params[:payment_type],
					:collection_status => mp_params[:collection_status]
				}
		}

		it { expect(response.status).to eq 302 }
		it { expect(Order).to have(1).record }

	end

	describe 'GET single_checkout_pending' do
		login_user

		before {
			mp_params = mercado_pago_params(user, product)
			get :single_checkout_pending,
				params: {
					:collection_id => mp_params[:collection_id],
					:preference_id => mp_params[:preference_id],
					:payment_type => mp_params[:payment_type],
					:collection_status => mp_params[:collection_status]
				}
		}

		it { expect(response.status).to eq 302 }
		it { expect(Order).to have(1).record }

	end

	describe 'GET single_checkout_cancelled' do
		login_user

		before {
			mp_params = mercado_pago_params(user, product)
			get :single_checkout_cancelled,
				params: {
					:collection_id => mp_params[:collection_id],
					:preference_id => mp_params[:preference_id],
					:payment_type => mp_params[:payment_type],
					:collection_status => mp_params[:collection_status]
				}
		}

		it { expect(response.status).to eq 302 }
		it { expect(Order).to have(1).record }

	end


end
