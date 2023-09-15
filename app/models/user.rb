class User < ApplicationRecord
  has_one_attached :picture
  has_many :articles

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
