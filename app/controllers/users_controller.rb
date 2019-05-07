class UsersController < SessionsController
  include SessionsHelper

  def new
    @user = User.new
  end

  def create    
    
    @user = User.new(user_params)

    if User.find_by(username: params[:user][:username]) == nil && @user.save
      log_in @user
      redirect_to tweets_path
    else
      @user.errors.add(:username, "Already exists")
      render 'new'
    end
  end

  private
    def user_params
        params.require(:user).permit(:username)
    end
end
