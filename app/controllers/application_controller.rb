class ApplicationController < ActionController::Base
	include ApplicationHelper

	before_action :load_page_categories, :set_instagram, :set_original_url,
								:set_raven_context, :set_action

	def set_instagram
		instagram_client = Instagram.client(:access_token => INSTRAGRAM_ACCESS_TOKEN)
		begin
			@instagram_username = instagram_client.user.username
			@instagram_images = instagram_client.user_recent_media(:count => 4)
		rescue
			@instagram_username = 'lazlo.la'
			@instagram_images = nil
		end
	end

	def load_page_categories
		@page_categories = Category.all
	end

	private

	def set_action
		@action = params[:action].present? ? params[:action] : ''
	end

	def set_og_tags title=nil, description=nil, image=nil
		@og_title = title + ' || Lazlo'
		@og_description = description
		@og_image = image
	end

	def resource_absolute_path asset_name
		ActionController::Base.helpers.asset_path(asset_name)
	end

	def set_original_url
		@current_url = request.original_url
	end

	private

	def set_raven_context
		if Rails.env.production?
			Raven.user_context(id: session[:current_user_id]) # or anything else in session
			Raven.extra_context(params: params.to_unsafe_h, url: request.url)
		end
	end

end
