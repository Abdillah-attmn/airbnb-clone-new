class Car < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  validates_presence_of :title
  validates_presence_of :price
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photocar
end
