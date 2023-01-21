class RecipesController < ApplicationController
    before_action :authorize

    def index
        recipes = Recipe.all 
        render json: recipes, status: :created
    end

    def create
        user = User.find(session[:user_id])
        recipe = user.recipes.create(params.permit(:title, :instructions, :minutes_to_complete))
        if recipe.valid?
            render json: recipe, status: :created
        else
            render json: {errors: recipe.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private

    def authorize
        unless session.include? :user_id
            render json: {errors: ["Please Log in"]}, status: :unauthorized
        end
    end
end
