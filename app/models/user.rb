class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :balance
  has_many :services
  has_many :trades
  has_many :reviews

  # Devise will validate signup params automatically
end
