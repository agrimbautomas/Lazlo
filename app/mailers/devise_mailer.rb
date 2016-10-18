class DeviseMailer < Devise::Mailer
  layout 'mailer'

  def welcome(resource)
    @resource = resource

    mail(to: @resource.email, subject: t('account.register.welcome_mail_subject'), from: mailer_sender(devise_mapping), reply_to: mailer_reply_to(devise_mapping), template_path: 'devise/mailer')
  end
end