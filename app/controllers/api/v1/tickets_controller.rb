class Api::V1::TicketsController < ApplicationController

  def create
    @ticket = Ticket.new(tickets_params)
    @ticket.tags = tickets_params[:tags]
    if @ticket.save
      respond_with @ticket, status: :created
    else
      render json: @ticket.errors, status: 422
    end
  end


private
  def tickets_params
    params.permit(:user_id, :title, :tags => [])
  end
end
