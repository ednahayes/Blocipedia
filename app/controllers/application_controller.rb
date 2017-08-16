class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include Pundit
  
  
  #after_action :verify_authorized, except: :index
  #after_action :verify_policy_scoped, only: :index

  
  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

 def user_not_authorized(exception)
   policy_name = exception.policy.class.to_s.underscore

   flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
   redirect_to(request.referrer || root_path)
 end

  #def admin_list
    #authorize Wiki # we don't have a particular post to authorize
  # Rest of controller action
 # end  
end

