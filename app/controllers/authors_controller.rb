class AuthorsController < ApplicationController

  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response

  def show
    author = find_author
    render json: author
  end

  def create
    author = Author.create!(author_params)
    render json: author, status: :created
  end

  private
  
  def author_params
    params.permit(:email, :name)
  end

  def find_author
    Author.find(params[:id])
  end
  
  # def render_not_found_response
  #   errors.add()
  # end

  def render_record_invalid_response(invalid)
    render json: {errors: invalid.record.errors}, status: :unprocessable_entity
  end
end
