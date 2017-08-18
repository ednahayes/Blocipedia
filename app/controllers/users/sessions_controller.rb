class Users::SessionsController < Devise::SessionsController
 #had to # following line getting error
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
   def new
     super
   end

  # POST /resource/sign_in
   def create
     super
   end

  # DELETE /resource/sign_out
   def destroy
     super
   end
   
   def show
    @user = authorize User.find(params[:id])
    @wikis = @user.wikis.visible_to(current_user, user.admin)
    #@private_wikis = @wikis.where(private: true)
    #@public_wikis = @wikis.where(private: false)
   end
   
   def upgrade(current_user)
    @wikis.user = current_user.wikis
    @user = User.find(params[:id])
    @user.update_attribute(:role, 'premium')
    @wikis.user.each do |wiki|
      wiki.update_attribute(:private, true)
    end 
    redirect_to wiki_path
   end 
   
  def downgrade(current_user)
    @wikis.user = current_user.wikis
    @user = User.find(params[:id])
    
    if @user.downgrade!
      @user.update_attribute(:role, 'standard')
      @wikis.user.each do |wiki|
        wiki.update_attribute(:private, false)
       end 
      flash[:notice] = "You've been downgraded to standard. Your private wikis are now public."
      redirect_to wiki_path
    else
      flash[:error] = "There was an error updating your account. Please try again."
      redirect_to :back
    end
  end
  

   def pundit_user
    User.find_by_other_means
   end



   protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
