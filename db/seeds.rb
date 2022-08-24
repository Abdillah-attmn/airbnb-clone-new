# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
Review.destroy_all
Booking.destroy_all
Car.destroy_all
User.destroy_all

5.times do
  user = User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name,
                      email: Faker::Internet.email, photo: Faker::Avatar.image,
                      password: Faker::Internet.password)
  2.times do
    car = Car.create!(title: Faker::Vehicle.make_and_model, content: Faker::Vehicle.fuel_type,
                      photo: "https://source.unsplash.com/random/?car",
                      address: Faker::Address.full_address, latitude: Faker::Address.latitude,
                      longitude: Faker::Address.longitude, price: (120..130).to_a.sample,
                      user: user)

    booking = Booking.create!(start_date: Faker::Date.in_date_period,
                              end_date: Faker::Date.in_date_period,
                              value: (0..10).to_a.sample, status: ["Pending guest request", "Pending host validation",
                                                                   "Confirmed", "Canceled"].sample,
                              car: car, user: user)
    Review.create!(rating: (0..10).to_a.sample, content: "It's good", booking: booking )
  end
end
