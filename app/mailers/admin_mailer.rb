class AdminMailer < AppMailer

  after_action :save_email_contact, :only => [:contact_email]

  def contact_email params
    @name = params[:macain_name]
    @email = params[:macain_email]
    @message = params[:macain_message]

    @url = 'http://macain.com.ar/'
    mail(to: 'alo@macain.com.ar, tomas@theamalgama.com', subject: 'Siranushen Alert :) - Message from: ' + @name)
  end

  def purchase_product_admin_notification params
    @user = params[:user]
    @product = params[:product]
    @image = params[:image]
    @order = params[:order]
    @message = params[:message]
    @url = 'http://macain.com.ar/'

    mail(to: 'alo@macain.com.ar, tomas@theamalgama.com', subject: 'Papin! Papin! ' +
        @user.email + ' ' + @message  + ' la compra de una ' + @product.name)
  end

  private
  def save_email_contact
    UserContact.create(:name => @name, :email => @email, :message => @message)
  end

end