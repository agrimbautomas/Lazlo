class Api::V1::ApiController < ActionController::Base
	include ApiHandlers

	protect_from_forgery with: :null_session
	skip_before_action :verify_authenticity_token

	before_action :authenticate_user!

end
