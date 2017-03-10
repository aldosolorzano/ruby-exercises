class SessionsController < ApplicationController
# skip_before_action :verify_authenticity_token

  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user&.authenticate params[:password]
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Signed up Succesfully'
    else
    render :new
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path,notice: 'Succesfully Sign out'
  end

end
