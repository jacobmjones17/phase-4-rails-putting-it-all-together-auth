require "byebug"
class RecipesController < ApplicationController
    def create
        user = User.find_by(id: session[:user_id])
        
        if user
            recipe = user.recipes.create(recipe_params)
            if recipe.valid?
            render json: recipe, status: :created
            else 
            render json: { errors: [recipe.errors.full_messages] }, status: :unprocessable_entity
            end
        else
            render json: { errors: ["Not authorized"] }, status: :unauthorized
        end
    end
    
    def index
        recipes = Recipe.all

        if session[:user_id]
        render json: recipes
        else
        render json: { errors: ["Not authorized"] }, status: :unauthorized
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
        
end
