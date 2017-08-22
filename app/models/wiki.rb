class Wiki < ApplicationRecord
    before_create :owner
    belongs_to :user
    has_many :collaborators
    has_many :users, :through => :collaborators
    
    default_scope { order('created_at DESC') }
    #default_scope { where(private: false) }
    
    scope :visible_to, -> (user) { user ? all : joins(:wiki).where('wikis.private' => false) }  
    
    
    
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :user, presence: true 
    
    def owner
    self.user_id = user.id
    end
    
    def collaborators
        #Collaborator.where( id: users.pluck(:collaborator_id)) refractored
        users.collaborators
    end
    
    
end
