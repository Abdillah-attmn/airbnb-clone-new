class Review < ApplicationRecord
  belongs_to :booking
  validates_presence_of :content, presence: true
  validates_presence_of :rating, presence: true
end
