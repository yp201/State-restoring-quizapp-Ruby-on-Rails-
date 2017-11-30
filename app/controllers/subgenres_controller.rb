class SubgenresController < ApplicationController
  def new
  end

  def all
	
	  @subgenres = Subgenre.where genre_id: params[:genre_id]
  	render json: @subgenres

  end

end
