module ServicesHelper
    def owner_name(user_id)
        owner = User.find_by(id: user_id)
        "#{owner.first_name} #{owner.last_name}"
    end
end
