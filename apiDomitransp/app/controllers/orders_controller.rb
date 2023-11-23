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

  def new
    @order = Order.new
    @order.packs.build
  end

  def create
    header_token = request.headers["token"]
    user = User.find_by(token: header_token)

    if user.nil?
      head :not_found
      return
    end

    order_params = params.require(:order).permit(:consecutivo, :avatar, :destino, :origen, :estado, :codigo_envio, :valor, :company_id, packs_attributes: [:tipo, :cantidad])

    @order = user.orders.build(order_params)
    @order.valor = 0.0 
    @order.estado = "En espera"

    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    head :not_found
  rescue StandardError => e
    puts "Error en controlador order: #{e.message}, Clase: #{e.class}"
    head :internal_server_error
  end

end
