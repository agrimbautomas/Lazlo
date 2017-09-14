require 'spec_helper'

RSpec.describe AdminMailer, type: :mailer do

  describe 'instructions' do

	 let(:user) { build(:user) }
	 let(:mail) { AdminMailer.confirmation_instructions(user, user.confirmation_token) }

	 it 'renders the subject' do
		expect(mail.subject).to eq(I18n.t('devise.mailer.confirmation_instructions.subject'))
	 end

	 it 'renders the receiver email' do
		expect(mail.to).to eq([user.email])
	 end

	 it 'assigns @name' do
		expect(mail.body.encoded).to match(user.name)
	 end

  end
end