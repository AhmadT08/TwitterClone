class DislikesController < ApplicationController
    def index
        render 'tweets/show'
    end

    def new
        @user = User.find(session[:user_id])
        @dislike = @user.dislikes.new
        respond_with(@dislike)
    end

    def create
        @user = User.find(session[:user_id])
        @tweet = Tweet.find(params[:tweet_id])
        @dislike = @tweet.dislikes.new(dislike_params)

        if !@tweet.dislikes.find_by(user_id: params[:user_id]) && @dislike.save
            render 'tweets/show'
        else
            destroy
        end
    end

    def destroy
        @user = User.find(session[:user_id])
        @tweet = Tweet.find(params[:tweet_id])
        @dislike = @tweet.dislikes.find_by(user_id: params[:user_id])
        @dislike.destroy
        render 'tweets/show'
    end
    
    private
    def dislike_params
        params.permit(:tweet_id, :user_id)
    end
end
