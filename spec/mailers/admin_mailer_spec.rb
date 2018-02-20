require 'spec_helper'

RSpec.describe AdminMailer, type: :mailer do

  let(:user) {build(:user)}

  describe 'should send contact_email' do

	 let(:mail) {AdminMailer.contact_email(params)}
	 let(:params) {{:lazlo_name => user.name,
						 :lazlo_email => user.email,
						 :lazlo_message => 'A message'}}

	 it 'renders the subject' do
		expect(mail.subject).to eq(I18n.t('admin_mail_mailer.contact.subject', name: user.name))
	 end

	 it 'renders the receiver email' do
		expect(mail.to.first).to eq(Settings.admin.emails)
	 end

	 it 'assigns displays user name' do
		expect(mail.body.encoded).to match(user.name)
	 end

  end

end