class Review < ApplicationRecord
  belongs_to :booking
  validates_presence_of :content
  validates_presence_of :rating
end
