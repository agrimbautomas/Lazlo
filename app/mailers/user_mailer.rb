class UserMailer < AppMailer

  def confirmation_instructions(record, token, opts={})
    @images = {
        :logo => asset_absolute_path('logo-alomacain.png'),
        :background => asset_absolute_path('fondo-colores.png'),
        :account_icon => asset_absolute_path('new-account-icon.png'),
    }
    super(record, token, opts={})
  end


  def reset_password_instructions(record, token, opts={})
    @images = {
        :logo => asset_absolute_path('logo-alomacain.png'),
        :background => asset_absolute_path('fondo-colores.png'),
        :lock => asset_absolute_path('lock-icon-macain.png'),
    }
    super(record, token, opts={})
  end

  def success_purchase_user_email params
    @images = {
        :logo => asset_absolute_path('logo-alomacain.png'),
        :background => asset_absolute_path('fondo-colores.png')
    }
    @user = params[:user]
    @product = params[:product]
    @order = params[:order]
    @message = params[:message]
    mail(to: @user.email, subject: "Gracias por comprar nuestro producto #{@order.title}")
  end

end