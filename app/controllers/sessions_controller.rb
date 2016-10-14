class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  def create
    email = params['user']['email']
    password = params['user']['password']
    resource = User.find_by_email email
    if resource and resource.valid_password? password
      resource.password = password
      sign_in_and_redirect(resource_name, resource)
    else
      failure(resource_name, resource)
    end
  end

  def failure resource_name, resource
    @resource = resource
    respond_to do |format|
      format.html { warden.authenticate!(:scoper => resource_name, :recall => "#{controller_path}#new") }
      format.json { return render :json => {:success => false, :errors => ["Login failed."]} }
    end
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource

    respond_to do |format|
      format.html do
        if !session[:return_to].blank?
          redirect_to session[:return_to]
          session[:return_to] = nil
        else
          respond_with resource, :location => root_path
        end
      end

      format.json { return render :json => {:success => true, user: { first_name: resource.first_name, last_name: resource.last_name, antenna: resource.antenna?, judge: resource.judge? } } }
    end
  end

end
