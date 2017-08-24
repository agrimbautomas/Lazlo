class AdminMailer < AppMailer

  after_action :save_email_contact, :only => [:contact_email]

  def contact_email params
	 @name = params[:macain_name]
	 @email = params[:macain_email]
	 @message = params[:macain_message]
	 mail(to: RECEIVERS, subject: "Siranushen Alert :) - Mensaje de: #{@name}")
  end

  def success_purchase_admin_email params
	 @user = params[:user]
	 @product = params[:product]
	 @image = params[:image]
	 @order = params[:order]
	 @message = params[:message]

	 mail(to: RECEIVERS, subject: "Papin! Papin! #{@user.email}  realizó la compra de #{@order.title}")
  end

  def pending_purchase_admin_email params
	 @user = params[:user]
	 @product = params[:product]
	 @image = params[:image]
	 @order = params[:order]
	 @message = params[:message]

	 # Todo Check not sending email
	 mail(to: RECEIVERS, subject: "Flann...! El usuario #{@user.email} dejo pendiente la compra de #{@order.title}")
  end

  def cancelled_purchase_admin_email params
	 @user = params[:user]
	 @product = params[:product]
	 @image = params[:image]
	 @order = params[:order]
	 @message = params[:message]

	 # Todo Check not sending email
	 mail(to: RECEIVERS, subject: "Flann...! El usuario #{@user.email} cancelo la compra de #{@order.title}")
  end

  private
  def save_email_contact
	 UserContact.create(:name => @name, :email => @email, :message => @message)
  end

end