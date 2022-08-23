class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :cars
  has_many :reviews, through: :bookings
  validates :email, presence: true, format: { with: // }
  validates_presence_of :lastname
  validates :firstname, presence: true, uniqueness: { scope: :lastname }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
