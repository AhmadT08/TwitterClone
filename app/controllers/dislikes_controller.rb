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
            if @tweet.likes.find_by(user_id: params[:user_id]) != nil
                @tweet.likes.find_by(user_id: params[:user_id]).destroy
            end
        else
            destroy
            return
        end
        redirect_to '/tweets/' + @tweet.id.to_s
    end

    def destroy 
        @tweet.dislikes.find_by(user_id: session[:user_id]).destroy
        redirect_to '/tweets/' + @tweet.id.to_s
    end

    def exists?
        if @tweet.dislikes.find_by(user_id: session[:user_id]) != nil
            return true
        else
            return false
        end
    end
    
    private
    def dislike_params
        params.permit(:tweet_id, :user_id)
    end
end
