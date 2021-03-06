class DowngradeController < ApplicationController
  def new
  end
  
  def create
    current_user.update_attributes(role: 'standard')
    wikis = Wiki.all
    wikis.each do |wiki|
      if wiki.user.id == current_user.id
        wiki.update_attribute(:private, false)
      end
    end
        
    flash[:notice] = "You have successfully downgraded your account."
        
    redirect_to wikis_path(current_user)
  end
end
