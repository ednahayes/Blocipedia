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
    
    def resolve
      scope.where(private: false).or(scope.where(user_id: @user.try(:id)))
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
  
end