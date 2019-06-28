class SessionsController < ApplicationController
  def new
  end

  def create
    binding.pry
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = 'Success'
      redirect_to 'tasks/index'
    else
      flash.now[:danger] = 'Failed'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logout'
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
