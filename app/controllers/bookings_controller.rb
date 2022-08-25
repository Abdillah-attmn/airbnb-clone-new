class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show update destroy]

  # POST /bookings
  def create
    # raise
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.car = Car.find(params[:car_id])
    @booking.status = Booking::PENDING[:pending_host]
    if @booking.save!
      redirect_to bookings_path
    else
      redirect_to car_path(@car), status: :unprocessable_entity
    end
  end

  # GET /Bookings
  def index
    @bookings = policy_scope(Booking)
    @my_bookings = @bookings.where(user: current_user)
    user_car = current_user.cars
    @my_car_bookings = user_car.map { |car| car.bookings }
  end

  # GET /Bookings/:id
  def show
    @car = @booking.car
  end

  def update
    @booking.status = Booking::PENDING[:pending_host]
    @booking.save!
    redirect_to booking_path(@booking)
  end

  def destroy
    @review = @booking.review
    @review.destroy
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :value)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
