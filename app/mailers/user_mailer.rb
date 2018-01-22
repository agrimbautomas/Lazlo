class UserMailer < AppMailer

  def confirmation_instructions(record, token, opts={})
	 @images = mail_images
	 @images[:account_icon] = asset_absolute_path('new-account-icon.png')
	 super(record, token, opts={})
  end


  def reset_password_instructions(record, token, opts={})
	 @images = mail_images
	 @images[:lock] = asset_absolute_path('lock-icon-lazlo.png')
	 super(record, token, opts={})
  end

  def success_purchase_user_email params
	 @images = mail_images
	 @user = params[:user]
	 @order = params[:order]
	 @message = params[:message]

	 mail(to: @user.email, subject: I18n.t('user_mailer.purchase.subject', order_title: @order.title))
  end

end