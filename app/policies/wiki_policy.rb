class WikiPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def update?
    #user.present?
    user.role == 'admin' || record.user == user || user.role == 'premium'
  end

  def destroy?
    user.role == 'admin' || record.user == user
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def show?
    user.present? 
  end

  def edit?
    user.present? && (user.role == 'admin' || record.user == user || user.role == 'premium')
  end
  
  class Scope 

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      wikis = []
      if user.role == 'admin' || user.role == 'premium'
        wikis = scope.all
      else
        wikis = scope.all
        scope.where(published: true)
        all_wikis.each do |wiki|
           if wiki.private == false 
             wikis << wiki 
           end
        end
      end
      wikis 
    end

  
    def permitted_attributes
      if user.admin? || user.owner_of?(wiki) || user.premium?
        [:title, :body, :private]
      else
        [:private]
      end
    end
  end
end