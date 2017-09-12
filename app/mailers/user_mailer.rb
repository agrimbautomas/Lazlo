class UserMailer < AppMailer

  def confirmation_instructions(record, token, opts={})
	 @images = mail_images
	 @images[:account_icon] = asset_absolute_path('new-account-icon.png')
	 super(record, token, opts={})
  end


  def reset_password_instructions(record, token, opts={})
	 @images = mail_images
	 @images[:lock] = asset_absolute_path('lock-icon-macain.png')
	 super(record, token, opts={})
  end

  def success_purchase_user_email params
	 @images = mail_images
	 @user = params[:user]
	 @product = params[:product]
	 @order = params[:order]
	 @message = params[:message]
	 mail(to: @user.email, subject: "Gracias por comprar nuestro producto #{@order.title}")
  end

end