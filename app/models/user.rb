class User < ApplicationRecord
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  has_many :wikis, dependent: :destroy
  attr_accessor :login, :role
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable,
         :validatable, :authentication_keys => [:login]
  
  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  } 
  
  # Only allow letter, number, underscore and punctuation.
  validate :validate_username
  
  
  enum role: [:user, :premium, :admin]
  after_initialize { self.role ||= :user if new_record? }

  USER_ROLES = {
    :admin => 0,
    :premium => 1,
    :user => 10
  }

  def set_as_admin 
    self.role = USER_ROLES[:admin]
  end

  def set_as_premium 
    self.role = USER_ROLES[:premium]
  end
  
  def set_as_user 
    self.role = USER_ROLES[:user]
  end

  def can_edit?(issue)
    true if owns?(issue) || admin? || premium?
  end

  def can_destroy?(issue)
    true if owns?(issue) || admin? || premium?
  end

  def can_resolve?(issue)
    true if owns?(issue) || admin? || premium?
  end

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
  
  def owns?(issue)
    true if self.id == issue.user_id
  end

  def admin?
    true if self.role_name == :admin
  end

  def role_name
    User.user_roles.key(self.role)
  end

  def self.user_roles
    USER_ROLES
  end  

         
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

end
