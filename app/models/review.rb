class Review < ApplicationRecord
    belongs_to :user
    belongs_to :trade

    validates_presence_of :trade_id, :user_id, :seller_id, :rating
    validates :trade_id, uniqueness: true
    validates :rating, numericality: { in: 1..5 }
end
