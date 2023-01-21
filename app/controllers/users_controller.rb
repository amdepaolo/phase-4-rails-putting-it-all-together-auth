class UsersController < ApplicationController

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {errors: ["couldn't create user"]}, status: :unprocessable_entity
        end
    end

    def show
        user = User.find(session[:user_id])
        render json: user, status: :created
    rescue ActiveRecord::RecordNotFound
        render json: {error: ["User not logged in"]}, status: :unauthorized
    end

    private

    def user_params
        params.permit(:username, :bio, :image_url, :password, :password_confirmation)
    end
end
