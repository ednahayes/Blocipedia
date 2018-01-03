class User < ApplicationRecord
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  has_many :wikis, :through => :collaborators, dependent: :destroy
  has_many :collaborators
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
  #validate :validate_username
  enum role: [:standard, :premium, :admin]
  after_initialize { self.role ||= :standard }

  
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

    def downgrade!
    ActiveRecord::Base.transaction do
      self.update_attribute(:role, 'standard')
      self.wikis.where(private: true).all.each do |wiki|
        wiki.update_attribute(:private, false)
       end
      end
    end
    
  def admin?
    role == 'admin'
  end

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end
  
  def self.wikis
    Wiki.where(id: pluck(:wiki_id))
  end
  
  def self.collaborators
    Collaborator.where(id: pluck(:user_id))
  end
  
  def wiki
    Wiki.find(wiki_id)
  end
end
