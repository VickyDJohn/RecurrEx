class SessionsController < ApplicationController
include SessionsHelper
  def new
    render 'new'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to their profile or a different page
      log_in user
      redirect_to home_index_logged_in_path
    else
      # Display an error message and render the login form again
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    logout_url
    redirect_to root_url
  end
end
