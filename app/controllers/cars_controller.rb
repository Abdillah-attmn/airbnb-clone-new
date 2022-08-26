require 'date'
class CarsController < ApplicationController
  before_action :set_car, only: %i[show edit update destroy]

  # GET /cars
  def index
    @cars = policy_scope(Car)
  end

  # GET /cars/new
  def new
    @car = Car.new
    authorize @car
  end

  # GET /cars/:id
  def show
    @booking = Booking.new
    @markers = [
      {
        lat: @car.latitude,
        lng: @car.longitude,
        info_window: render_to_string(partial: "info_window", locals: { car: @car })
      }
    ]
    @bookings = @car.bookings
    authorize @car
  end

  # POST /cars
  def create
    @car = Car.new(car_params)
    @car.user = current_user
    authorize @car
    if @car.save
      redirect_to cars_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /cars/:id/edit
  def edit
    authorize @car
  end

  # PATCH /cars/:id
  def update
    authorize @car
    if @car.update(car_params)
      redirect_to car_path(@car)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /cars/:id
  def destroy
    authorize @car
    @car.bookings.each do |booking|
      booking.review.destroy unless booking.review == nil
    end
    @car.bookings.destroy_all
    @car.destroy
    redirect_to root_path, status: :see_other, notice: "Your car has been Destroyed"
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:title, :content, :price, :address, :city, :photocar)
  end
end
