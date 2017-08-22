class CollaboratorsController < ApplicationController
  
  def index
    @collaborators = Collaborator.all
  end
  
  def new
    @collaborator = Collaborator.new(collaborator_params)
  end

  def create
    @collaborator = Collaborator.new(collaborator_params)
    @wiki = Wiki.find(params[:collaborator][:wiki_id])
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
    @wiki = @collaborator.wiki
    if @collaborator.delete
      flash[:notice] = "Collaborator removed successfully."
      redirect_to @wiki
    else
      flash[:error] = "Something went wrong."
      redirect_to @wiki
    end
  end
  
  private

  def collaborator_params
    params.require(:collaborator).permit(:user_id, :wiki_id)
  end
end
