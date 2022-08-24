class User < ApplicationRecord
  validates :email, presence: true
  validates_presence_of :lastname
  validates :firstname, presence: true, uniqueness: { scope: :lastname }
  # validates :photo, presence: true
  validates :encrypted_password, presence: true
  has_many :bookings, dependent: :destroy
  has_many :cars
  has_many :reviews, through: :bookings
  validates_presence_of :email
  # validates_presence_of :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
