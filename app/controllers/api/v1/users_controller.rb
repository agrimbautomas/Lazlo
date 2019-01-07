class Api::V1::UsersController < Api::V1::ApiController
	before_action :authenticate_user!, except: [:contact_email, :add_to_newsletter]
	protect_from_forgery with: :exception
	
	def contact_email

		#Todo Refactor, add csrf validations

		if params['authenticity_token'].present?
			AdminMailer.contact_email(contact_params).deliver_now
			flash[:notice] = 'Se envió el mensaje, en breve nos vamos a estar contactando. Gracias!'
			redirect_to root_path
		else
			raise Exception;
		end
	end

	def add_to_newsletter
		begin
			MailChimpApi.add_member email: params[:email] unless params[:email].nil?
			render_successful_empty_response
		rescue Exception => ex
			response = Hash.new
			response[:status] = 'failed'
			response[:message] = ex.title == 'Member Exists' ? 'El usuario ya esta registrado' : 'El email no es válido'
			render_response_message hash: response, status: 200
		end
	end

	private
	def contact_params
		params.permit(:lazlo_name, :lazlo_email, :lazlo_message, :authenticity_token)
	end

end
