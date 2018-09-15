require 'uri'
require 'net/http'

class MailChimpApi
	MC_LIST_ID = "94156810d0"

	def self.add_member email:
		add_member = self.new email: email
		add_member.execute
	end

	def initialize email:
		@gibbon = Gibbon::Request.new(api_key: Settings.mailchimp.api_key)
		@email = email
	end

	def execute
		do_request
	end

	def do_request
		params = {
			email_address: @email,
			status: "subscribed",
			merge_fields: {
				FNAME: "Lazlo",
				LNAME: "Lazlo" }
		}
		@gibbon.lists(MC_LIST_ID).members.create(body: params)

	end
end