class OrdersController < ApplicationController
  def index
    header_token = request.headers["token"]

    if !header_token.nil?
      user = User.find_by(token: header_token)
      if !user.nil?
        puts "el user: #{user} y tipo #{user.class}"
        orders = user.orders.all
        puts "Esto es orders: #{orders}"
        render json: orders, status: :ok
      else
        head :not_found
      end
    else
      head :not_found
    end
  rescue => e
    puts "error encontrolador order: #{e}"
    head :internal_server_error
  end
end
