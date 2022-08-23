class CarsController < ApplicationController
  before_action :set_car
  def show; end

  def create
    @car.books = Books.new
  end
  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:start_date, :end_date)
  end
end
