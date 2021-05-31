class Service < ApplicationRecord
    belongs_to :user
    has_many :trades

    validates_presence_of :name, :description, :category, :user_id, :region, :price, :archived

    # inheritance override to avoid confusion
    def seller
        User.find(self.user_id)
    end
end
