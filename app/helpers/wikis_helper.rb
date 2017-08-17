module WikisHelper
    def user_is_authorized_for_wikis?
        current_user && (current_user == wiki.user || current_user.role == 'admin' || current_user.role == 'premium')
    end
    
    def wiki_private_belongs_to_current_user?
        @wiki.private == 'true' && current_user.owner_of?(wiki)
    end
end
