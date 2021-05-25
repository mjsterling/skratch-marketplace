class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :reviews 
  has_many :services
  has_many :trades
  has_one :avatar
end
