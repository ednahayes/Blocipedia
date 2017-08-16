class WikiPolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def update?
    user.present?
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
    user.present?
  end
  
 class Scope 

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      if user.admin?
        scope.all
      elsif 
        scope.all
        scope.where(published: true)
      end
    end
 end

  
  def permitted_attributes
    if user.admin? || user.owner_of?(wiki) || user.premium?
      [:title, :body, :private]
    else
      [:private]
    end
  end
end