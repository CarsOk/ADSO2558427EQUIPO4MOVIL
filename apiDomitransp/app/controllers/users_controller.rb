class UsersController < ApplicationController
    def show
        header_token = request.headers["token"]
        if !header_token.nil?
            user = User.find_by(token: header_token)
            if !user.nil?
                render json: user, status: :ok
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