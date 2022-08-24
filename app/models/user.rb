class User < ApplicationRecord
<<<<<<< HEAD
  validates :email, presence: true
=======
  # validates :email, presence: true, format: { with: /\A\S*@\w*\.[a-zA-Z]{2,3}\z/ }
>>>>>>> 3d969ca6c58b0e225c2dfb8ef08755a0edca1672
  validates_presence_of :lastname
  validates :firstname, presence: true, uniqueness: { scope: :lastname }
  validates :photo, presence: true
  validates :encrypted_password, presence: true
  has_many :bookings, dependent: :destroy
  has_many :cars
  has_many :reviews, through: :bookings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
