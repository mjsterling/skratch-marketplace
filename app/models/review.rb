class Review < ApplicationRecord
    belongs_to :trade

    validates_presence_of :trade_id, :rating
    validates :trade_id, uniqueness: true
    validates :rating, numericality: { in: 1..5 }
end
