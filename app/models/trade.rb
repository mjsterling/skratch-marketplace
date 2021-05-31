class Trade < ApplicationRecord
    belongs_to :user
    belongs_to :service
    has_one :review

    def seller
        User.find(self.service.user_id)
    end

    validates_presence_of :user_id, :service_id
end
