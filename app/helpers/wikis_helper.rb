module WikisHelper
    def user_is_authorized_for_wikis?
        current_user && (current_user == wiki.user || current_user.admin? || current_user.premium?)
    end
end
