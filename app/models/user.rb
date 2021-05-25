class User < ApplicationRecord
  mount_base64_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :reviews
  has_many :services
  has_many :trades
end
