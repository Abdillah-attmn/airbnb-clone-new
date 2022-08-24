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
    @nb_days = nb_day_and_total_price(@checkin, @checkout)[0]
    @total_price = nb_day_and_total_price(@checkin, @checkout)[1]
    @bookings = @car.bookings
    firstname = @car.user.firstname
    lastname = @car.user.lastname.upcase
    @alert_message = "You are viewing the car of #{firstname} #{lastname}"
  end

  def create
    @car = Car.new(car_params)
    if @car.save!
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
    redirect_to root_path, status: :see_other
  end

  private

  def nb_day_and_total_price(start_date, end_date)
    unless start_date.blank? || end_date.blank?
      from = start_date.split('/')
      to = end_date.split('/')
      start = Date.new(from[2].to_f, from[1].to_f - 1, from[0].to_f)
      finish = Date.new(to[2].to_f, to[1].to_f - 1, to[0].to_f)
      nb_days = (finish - start).to_f
      total_price = (nb_days * @car.price.to_f).round
    end
    [nb_days, total_price]
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:title, :content, :price)
  end
end
