module ChargesHelper
    
    def upgrade(current_user)
        @wikis.user = current_user.wikis
        @user = User.find(params[:id])
        @user.update_attribute(:role, 'premium')
        @wikis.each do |wiki|
            wiki.update_attribute(:private, true)
        end 
        redirect_to wiki_path
    end 
end
