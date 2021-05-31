class Service < ApplicationRecord
    belongs_to :user
    has_many :trades

    validates_presence_of :name, :description, :category, :user_id, :region, :price, :archived
end
