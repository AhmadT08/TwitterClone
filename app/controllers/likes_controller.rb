class LikesController < ApplicationController
    def index
        render 'tweets/show'
    end

    def new
        @user = User.find(session[:user_id])
        @like = @user.likes.new
        respond_with(@like)
    end

    def create
        @user = User.find(session[:user_id])
        @tweet = Tweet.find(params[:tweet_id])
        @like = @tweet.likes.new(like_params)

        if !@tweet.likes.find_by(user_id: params[:user_id]) && @like.save
            render 'tweets/show'
        else
            destroy
        end
    end

    def destroy
        @user = User.find(session[:user_id])
        @tweet = Tweet.find(params[:tweet_id])
        @like = @tweet.likes.find_by(user_id: params[:user_id])
        @like.destroy
        render 'tweets/show'
    end
    
    private
    def like_params
        params.permit(:tweet_id, :user_id)
    end
end
