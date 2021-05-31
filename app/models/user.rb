class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :balance
  has_many :services
  has_many :trades
  has_many :reviews
  has_many :payments

  validates_presence_of :email, :password, :first_name, :last_name, :region

  def rating
    Review.where(seller_id: self.id).average(:rating).round(1)
  end
end
