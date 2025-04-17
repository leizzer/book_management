class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show ]

  # GET /reservations
  def index
    @reservations = Reservation.all

    render json: @reservations
  end

  # GET /reservations/1
  def show
    render json: @reservation
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params.expect(:id))
  end
end
