class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  validates_presence_of :title
  validates_presence_of :price
  has_one_attached :photocar
end
