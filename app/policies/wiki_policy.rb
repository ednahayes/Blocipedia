class WikiPolicy < ApplicationPolicy

  def index?
    user_is_owner_of_record? || @record.private == false
    unless user.role == 'premium' || user.role == 'admin'
    end
    #user.present?
  end

  def update?
    #user.present?
    user.role == 'admin' || user_is_owner_of_record?
  end

  def destroy?
    user.role == 'admin' || user_is_owner_of_record?
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def show?
    user_is_owner_of_record? #|| @record.private == false
    #user.present? 
  end

  def edit?
    #user.present? 
    user.role == 'admin' || user_is_owner_of_record?
  end
  
  class Scope 

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    #def resolve
     # scope.where(private: false).or(scope.where(user_id: @user.try(:id)))
    #end

    def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all # if the user is an admin, show them all the wikis
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if !wiki.pivate? || wiki.owner == user || wiki.collaborators.include?(user)
             wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           end
         end
       else # this is the lowly standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if !wiki.private? || wiki.collaborators.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
    end
   
    
    
    def permitted_attributes
      if user.admin? || user.premium?
        [:title, :body, :private]
      else
        [:title, :body]
      end
    end
  end
  
  private
  def user_is_owner_of_record?
    @user == @record.user
  end
  
  def public?
    private == false
  end
  
end