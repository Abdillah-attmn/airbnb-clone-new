class BookingsController < ApplicationController

  def create
    @car = Car.find(params[:offer_id])
    @booking = booking.new(booking_params)
    @booking.car = @car
    @booking.user = current_user
    @booking.status = "Pending host validation"
    if @booking.end_date && @booking.start_date
      @booking.value = (@booking.end_date - @booking.start_date).to_f * @booking.car.price.to_f
    else
      @booking.value = 0
    end
    if @booking.save
      redirect_to bookings_path
    else
      redirect_to car_path(@car), status: :unprocessable_entity
    end
  end

  def index
    if current_user
    @bookings = Booking.where(user_id: current_user.id)
    @review = Review.new
    else
      redirect_to root_path
    end
  end

  def show
    set_booking
    @car = @booking.car
  end

  def update
    set_booking
    @booking.status = "Pending host validation"
    @booking.save!
    redirect_to booking_path(@booking)
  end

  def destroy
    set_booking
    @booking.destroy
    redirect_to root_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :value, :status)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
