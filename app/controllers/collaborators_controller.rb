class CollaboratorsController < ApplicationController
  
  def index
    @collaborators = User.all
    redirect_to @wiki
  end
  
  def new
    @collaborator = Collaborator.new(collaborator_params)
    @wiki = Wiki.find(params[:id])
    redirect_to @wiki
  end

  def create
    @collaborators = User.all
    @collaborator = @wiki.collaborators.build(collaborator_params)
    @wiki = Wiki.find(params[:collaborator][:wiki_id])
    @new_collaborator = Collaborator.new
    
    if @collaborator.save
      flash[:notice] = "Collaborator added successfully."
      redirect_to @wiki
    else
      flash[:error] = "Was not able to add collaborator, please try again."
      redirect_to @wiki
    end
  end

  def destroy
    @collaborator = Collaborator.find_by(params[:collaborator][:user_id], params[:collaborator][:wiki_id])
    @wiki = Wiki.find(params[:wiki_id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator removed successfully."
      redirect_to @wiki
    else
      flash[:error] = "Something went wrong."
      redirect_to @wiki
    end
  end
  
   def show
     @collaborator = Collaborator.find(collaborator_params)
     @wikis = @collaborator.wikis.visible_to(current_user)     
   end   
  
  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end
