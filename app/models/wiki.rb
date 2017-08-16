class Wiki < ApplicationRecord
    belongs_to :user
    has_many :users
    
    default_scope { order('created_at DESC') }
 
    scope :visible_to, -> (user) { user ? all : joins(:wiki).where('wikis.private' => true) }  
    
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :user, presence: true  
end
