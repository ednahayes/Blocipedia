class Collaborator < ApplicationRecord
  belongs_to :user
  belongs_to :wiki
  has_many :wikis
  
  def users
    Users.where(collaborator_id: id)
  end
  
  def wikis
   # Wiki.where( id: users.pluck(:wiki_id)) refractored
   users.wikis
  end
  
end
