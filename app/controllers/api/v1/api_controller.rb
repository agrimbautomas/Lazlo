class  Api::V1::ApiController < ActionController::Base
  #version 1

  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_action :authenticate_user!


end
