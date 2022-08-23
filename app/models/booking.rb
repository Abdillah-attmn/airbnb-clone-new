class Book < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_one :review
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :status
end
