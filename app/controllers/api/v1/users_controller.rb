class Api::V1::UsersController < Api::V1::ApiController

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
		MailChimpApi.add_member email: params[:email] unless params[:email].empty?
		render_successful_response
	end

	private
	def contact_params
		params.permit(:lazlo_name, :lazlo_email, :lazlo_message, :authenticity_token)
	end

end
