require 'spec_helper'

RSpec.describe UserMailer, type: :mailer do

  let(:user) {build(:user)}

  describe 'should send confirmation_instructions' do

	 let(:mail) {UserMailer.confirmation_instructions(user, user.confirmation_token)}

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

  describe 'should send reset_password_instructions' do

	 let(:mail) {UserMailer.reset_password_instructions(user, user.confirmation_token)}

	 it 'renders the subject' do
		expect(mail.subject).to eq(I18n.t('devise.mailer.reset_password_instructions.subject'))
	 end

	 it 'renders the receiver email' do
		expect(mail.to).to eq([user.email])
	 end

	 it 'assigns @name' do
		expect(mail.body.encoded).to match(user.name)
	 end

  end

  describe 'should send success_purchase_user_email' do

	 let(:order) {create(:order)}
	 let(:mail) {UserMailer.success_purchase_user_email(params)}
	 let(:params) {{:user => user, :order => order, :message => 'A message'}}

	 it 'renders the subject' do
		expect(mail.subject).to eq(I18n.t('user_mailer.purchase.subject', order_title: order.title))
	 end

	 it 'renders the receiver email' do
		expect(mail.to).to eq([user.email])
	 end

	 it 'assigns displays order title' do
		expect(mail.body.encoded).to match(order.title)
	 end

  end

end