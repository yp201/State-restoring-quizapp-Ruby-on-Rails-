class SinglechoicesController < ApplicationController
  def new
  end
    def all
	
  # @subgenres = Singlechoice.where subgenre_id: 1
	  @singlechoices = Singlechoice.where subgenre_id: params[:subgenre_id]
	# puts subgenres_params
  	render json: @singlechoices

  end

 

end
