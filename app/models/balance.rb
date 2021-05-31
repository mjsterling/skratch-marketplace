class Balance < ApplicationRecord
    belongs_to :user

    validates_presence_of :user_id, :balance
end
