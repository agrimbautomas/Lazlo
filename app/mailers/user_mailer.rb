class UserMailer < AppMailer

  def confirmation_instructions(record, token, opts={})
    @images = {
        :logo => asset_absolute_path('logo-macain-300.png'),
        :background => asset_absolute_path('fondo-colores.png'),
        :account_icon => asset_absolute_path('new-account-icon.png'),
    }
    super(record, token, opts={})
  end


  def reset_password_instructions(record, token, opts={})
    @images = {
        :logo => asset_absolute_path('logo-macain-300.png'),
        :background => asset_absolute_path('fondo-colores.png'),
        :lock => asset_absolute_path('lock-icon-macain.png'),
    }
    super(record, token, opts={})
  end

  def purchased_product_user_notification params
    @images = {
        :logo => asset_absolute_path('logo-macain-300.png'),
        :background => asset_absolute_path('fondo-colores.png'),
        :product =>  params[:image],
    }
    @user = params[:user]
    @product = params[:product]
    @order = params[:order]
    @message = params[:message]
    @url = 'http://macain.com.ar/'
    mail(to: @user.email, subject: 'Gracias por comprar nuestro producto ' + @product[:name])
  end

end