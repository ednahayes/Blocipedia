class WikisController < ApplicationController
  
  before_action :authorize_user, except: [:index, :show] 
  
  def index
    @wikis = Wiki.all
    #@wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end


  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])    
  end
  
  def create
     @wiki = Wiki.new(wiki_params)
     @wiki.user = current_user
     if @wiki.save
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :new
     end
  end  

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki
    if @wiki.update(wiki_params) #@wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end  
  
  
  
  def destroy
    @wiki = Wiki.find(params[:id])
 

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
        redirect_to @wiki
    else
      flash.now[:alert] = "There was an error deleting the wiki."
        render :show
    end
  end   
   
    private
    def wiki_params
        params.require(:wiki).permit(:title, :body, :private)
    end
 
  
    def authorize_user
        @wiki = Wiki.find(params[:id])
        unless current_user == @wiki.user || current_user.admin?
            flash[:alert] = "You must be an admin to do that."
            redirect_to wiki_path
        end
    end   
end
