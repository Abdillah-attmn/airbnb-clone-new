class Booking < ApplicationRecord
  PENDING = { pending_guest: "Pending guest request",
              pending_host: "Pending host validation",
              confirmed: "Confirmed", canceled: "Canceled" }
  belongs_to :user
  belongs_to :car
  has_one :review
  validates_presence_of :start_date
  validates_presence_of :end_date
end
