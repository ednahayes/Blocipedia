class CollaboratorsController < ApplicationController
  before_action :set_wiki
  
  def index
    @users = User.all
    #redirect_to @wiki
  end
  
  def create
    #@wiki = Wiki.find(params[:wiki_id])
    #@collaborators = User.all
    @user = User.find(params[:user_id])
    #@collaborator = Collaborator.new(collaborator_params)
    @collaborator = @wiki.collaborators.build(user_id: params[:user_id])
   
    if @collaborator.save!
      flash[:notice] = "Collaborator #{@user.email} added successfully."
      #redirect_to @wiki
    else
      flash[:error] = "Was not able to add collaborator #{@user.email}, please try again."
    end
    redirect_to wiki_collaborators_path(@wiki)
  end

  def destroy
    @user = User.find(params[:user_id])
    @collaborator = Collaborator.where(wiki_id: params[:id], user_id: params[:user_id]).first
    #@collaborator = Collaborator.find_by(params[:user_id])
    #@wiki = Wiki.find(params[:wiki_id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator #{@user.email} removed successfully."
    else
      flash[:error] = "#{@user.email} couldn't be removed, please try again."
    end
    redirect_to wiki_collaborators_path(@wiki)
  end
  
   def show
     @collaborator = Collaborator.find(collaborator_params)
     @wikis = @collaborator.wikis.visible_to(current_user)     
   end   
  
  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
  
  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
  
end
