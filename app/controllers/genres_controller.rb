class GenresController < ApplicationController
  def new
  end
  def all
  	@genres=Genre.all
  	render json: @genres
  end

end
