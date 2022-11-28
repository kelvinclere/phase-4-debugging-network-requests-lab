class ToysController < ApplicationController

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  
    wrap_parameters format: []
  
    def index
      toys = Toy.all
      render json: toys
    end
  
    def create
      toy = Toy.create!(toy_params)
      render json: toy, status: :created
    end
  
    def update
      toy = find_toy
      toy.update!(toy_params)
      render json: toy, status: :ok
    end
  
    def destroy
      toy = find_toy
      toy.destroy
      head :no_content
    end
  
    private
    
    def toy_params
      params.permit(:name, :image, :likes)
    end
  
    def find_toy
      Toy.find(params[:id])
    end
  
    def render_unprocessable_entity_response(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
  
    def render_not_found_response(exception)
      render json: { error: "#{exception.model} not found" }, status: :not_found
    end
  
  end
