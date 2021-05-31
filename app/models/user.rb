class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :balance
  has_many :services
  has_many :trades
  has_many :reviews, through: :trades
  has_many :payments

  validates :email, uniqueness: true
  validates_presence_of :email, :first_name, :last_name, :region

  def sales
    Trade.where(seller_id: self.id)
  end

  def rating
    Review.where(Tra sales.review.average(:rating).round(1)
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
