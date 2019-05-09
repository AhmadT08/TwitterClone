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
            if @tweet.dislikes.find_by(user_id: params[:user_id]) != nil
                @tweet.dislikes.find_by(user_id: params[:user_id]).destroy
            end
        else
            destroy
            return
        end
        redirect_to '/tweets/' + @tweet.id.to_s
    end

    def destroy
        @tweet.likes.find_by(user_id: params[:user_id]).destroy
        redirect_to '/tweets/' + @tweet.id.to_s
    end

    def exists?
        if @tweet.likes.find_by(user_id: session[:user_id]) != nil
            return true
        else
            return false
        end
    end
    
    private
    def like_params
        params.permit(:tweet_id, :user_id)
    end
end
