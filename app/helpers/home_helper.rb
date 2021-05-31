module HomeHelper
    def add_services_path
        return profile_services_path if current_user.first_name && current_user.region

        flash[:alert] = 'Please complete your profile before using Skratch.'
        edit_user_registration_path
    end
end
