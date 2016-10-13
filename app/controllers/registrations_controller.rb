class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource

    resource = User.new user_params

    if resource.save
      if resource.active_for_authentication?
#        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        DeviseMailer.welcome(resource).deliver_now unless resource.invalid?
        return render :json => {:success => true, user: {first_name: resource.first_name, last_name: resource.last_name, antenna: resource.antenna?}}
      else
#        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        return render :json => {:success => true}
      end
    else
#      clean_up_passwords resource
      return render :json => {:success => false, :errors => resource.errors}
    end
  end

  def update
    user = current_user
    user.attributes = edit_user_params
    puts "attributes"
    puts user.attributes
    respond_to do |format|
      if user.valid? and resource.save
        return render :json => {:success => true}
      else
        return render :json => {:success => false, :errors => user.errors}
      end
    end
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password,
                                 :email_confirmation, :password_confirmation, :conditions,
                                 :music_resource_country_id, :music_resource_residence_country_id, :wants_to_receive_emails, :favorite_language)
  end

  def edit_user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email,
                                 :email_confirmation, :password, :password_confirmation,
                                 :music_resource_country_id, :music_resource_residence_country_id, :favorite_language)
  end
end