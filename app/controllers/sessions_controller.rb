class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:session][:username].downcase)
    if @user 
      log_in @user
      redirect_to tweets_path
    else
      @user = User.new
      @user.errors.add(:username, "does not exists")
      render 'new'
    end
  end

  def show
    #redirect_to tweets_path
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
