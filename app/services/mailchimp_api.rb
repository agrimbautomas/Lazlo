require 'uri'
require 'net/http'

class MailChimpApi

	MC_LIST_ID = "94156810d0"
	MC_ENPOINT = "https://us19.api.mailchimp.com/3.0/lists/#{MC_LIST_ID}/members"

	def self.add_member email:
		add_member = self.new email: email
		add_member.execute
	end

	def initialize email:
		@email = email
	end


	def execute
		do_request
	end

	def do_request
		params = {
			:email_address => 'tomas@fromsite.com',
			:status => 'subscribed',
			:merge_fields => {
				:FNAME => 'lazlo',
				:LNAME => 'lazlo'
			}
		}
		x = Net::HTTP.post_form(URI.parse(MC_ENPOINT), params)
		puts x.body
		byebug
	end
end
