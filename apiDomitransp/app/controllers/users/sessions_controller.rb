# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    email = params[:email]
    puts "El email es: #{email}"
    if email.present?
      user = User.find_by(email: email)
      puts "User es equivalente a : #{user} y es tipo #{user.class}, #{user.inspect}"
      if user
        if user.code != nil
          delete = user.code.destroy
        end
        verification_code = rand(1000..9999)
        code = Code.create(code: verification_code, user_id: user.id)
        UsersMailer.codeVerification(user, verification_code).deliver_now
        head :ok
      else
        head :not_found
      end
    else
      head :not_found
    end
  rescue => e
    puts "Falle en create: #{e}"
    head :internal_server_error
  end

  def confirmUser
    email = params[:email]
    puts "El email es: #{email}"
    if email.present?
      user = User.find_by(email: email)
      puts "User es equivalente a : #{user} y es tipo #{user.class}, #{user.inspect}"
      if user
        if user.code != nil
          delete = user.code.destroy
        end
        verification_code = rand(1000..9999)
        code = Code.create(code: verification_code, user_id: user.id)
        UsersMailer.codeVerification(user, verification_code).deliver_now
        render json: { status: 200 }
      else
        render json: { status: 404, message: 'User not found' }
      end
    else
      render json: { status: 400, message: 'Email parameter missing' }
    end
  rescue => e
    puts "Falle en create: #{e}"
    render json: { status: 400 }
  end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
