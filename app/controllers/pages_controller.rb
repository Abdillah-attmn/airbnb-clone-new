class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @car = Car.new
    @cars = Car.all
  end
end
