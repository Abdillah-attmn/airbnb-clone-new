# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'faker'
Review.destroy_all
Booking.destroy_all
Car.destroy_all
User.destroy_all

files = %w[https://www.largus.fr/images/images/porsche_911-black-edition-2015.jpg https://www.wrapstyle.com/content/img_cache/1920x/1594897977-1171-GMC-Sierra-Black-Matt-1-.jpg https://sf2.autoplus.fr/wp-content/uploads/autoplus/2021/11/67-ferrari-daytona-sp3-1.jpg https://images.caradisiac.com/images/3/1/9/2/193192/S0-nouveau-suv-electrification-integration-au-groupe-stellantis-ou-va-maserati-697186.jpg https://cdn.drivek.it/configurator-imgs/cars/de/800/CHEVROLET/CAMARO/6994_COUPE-2-TURER/camaro-coupe-2016-front-2.jpg ]
cars_name = %w[porsche sierra ferrari maserati camaro]

i = 0
while i < 5 do
  user = User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name,
                      email: Faker::Internet.email, photo: Faker::Avatar.image,
                      password: "password"
  )
  # p files[i]
  p file = URI.open( files[i] )

  car = Car.new(title: cars_name[i], content: Faker::Vehicle.fuel_type,
                address: "11 rue benjamin franklin 77000 La Rochette", latitude: Faker::Address.latitude,
                longitude: Faker::Address.longitude, price: (120..130).to_a.sample,
                user: user)
  car.photocar.attach(io: file, filename: "#{file}.jpg", content_type: "image/jpg")
  car.save!

  booking = Booking.new(user: car.user,
                        start_date: Faker::Date.in_date_period,
                        end_date: Faker::Date.in_date_period,
                        status: ["Pending guest request", "Pending host validation",
                                 "Confirmed", "Canceled"].sample,
                        car: car)

  if (booking[:end_date] - booking[:start_date]) >= 0
    booking[:value] = car.price * (booking[:end_date] - booking[:start_date])
  else
    booking[:value] = -1
  end
  booking.save!
  Review.create!(rating: (0..5).to_a.sample, content: "It's good", booking: booking)

  i += 1
end
