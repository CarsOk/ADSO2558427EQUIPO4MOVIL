# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def verify_code
    # super
    puts "entre al controlador"
    email = params[:email]
    provided_code = params[:code]
    user = User.find_by(email: email)
    
    if !user.code.nil?
      if user.code.code == provided_code
        puts "esto es email: #{email}"
        puts "esto es code: #{provided_code}"
        puts "el code del user es: #{user.code.code}"
        if user.token.nil?
          user.update(token: generate_unique_token)
          user.code.destroy
          render json: { token: user.token }, status: :ok
        else
          user.code.destroy
          render json: { token: user.token }, status: :ok
        end
      else
        head :not_found
      end
      
      
    else
      puts "El user o code no es correcto"
      head :not_found
    end
  rescue => e
    puts "error verify code: #{e}"
    head :internal_server_error
  end

  # def confirm_user
  #   email = params[:email]
  #   provided_code = params[:code]
  #   user = User.find_by(email: email)

  #   if user && user.code == provided_code
  #     if user.token.nil?
  #       user.update(token: generate_unique_token)
  #       render json: { status: 201, token: user.token }
  #     else
  #       render json: { status: 201, token: user.token }
  #     end
      
  #   else
  #     render json: { status: 404 }
  #   end
  # rescue => e
  #   puts "error verify code: #{e}"
  #   render json: { status: 404 }
  # end
  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    super
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
  private

  def generate_unique_token
    loop do
      token = SecureRandom.hex(16)
      break token unless User.exists?(token: token)
    end
  end
end
