class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_one :review
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates :status, inclusion: { in: ["Pending guest request", "Pending host validation", "Confirmed", "Canceled"], allow_nil: true }
end
