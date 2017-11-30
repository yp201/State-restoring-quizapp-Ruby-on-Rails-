class SessionsController < ApplicationController

  def redirection
    if current_user.admin?
      log_out
      render :js => "window.location = '/login'"
    else
      render :js => "window.location = '/users/#{current_user.id}'"
    end
  end
  
  def create
    
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    	
      log_in user
    	if user.admin?
        redirect_to '/admin'
      else
        redirect_to user
      end
    else
    	render 'new'
    end	

  end

  def destroy

    log_out
    redirect_to login_path

  end
end
