require 'date'
class CarsController < ApplicationController
  before_action :set_car, only: %i[show edit update destroy]
  def index
    @cars = Car.all

    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

  def new
    @car = Car.new
  end

  def show
    @booking = Booking.new
    @checkin = params['start_date']
    @checkout = params['end_date']
    unless @checkin.blank? || @checkout.blank?
      from = @checkin.split('/')
      to = @checkout.split('/')
      #start = Date.new(from[2].to_f, from[1].to_f - 1, from[0].to_f)
      #finish = Date.new(to[2].to_f, to[1].to_f - 1, to[0].to_f)
      #nb_days = (finish - start).to_f
      #@total_price = (@nb_days * @car.price.to_f).round
      #@total_price = 120
    end
    @bookings = @car.bookings
    firstname = @car.user.firstname
    lastname = @car.user.lastname.upcase
    @alert_message = "You are viewing the car of #{firstname} #{lastname}"
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    if @car.save
      redirect_to car_path(@car)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    set_car
    if @car.update(car_params)
      redirect_to car_path(@car)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @car.destroy
    redirect_to root_path, status: :see_other, notice: "Your car has been Destroyed"
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:title, :content, :price, :address, :city, :photo)
  end
end
