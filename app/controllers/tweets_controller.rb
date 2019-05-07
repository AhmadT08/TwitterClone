class TweetsController < SessionsController
    helper_method :sort_column, :sort_direction

    def index
        @user = User.find(session[:user_id]).username
        @tweet = Tweet.new
        @tweets = Tweet.all.order(sort_column + ' ' + sort_direction)
    end
    
    def show
        @user = User.find(session[:user_id])
        @tweet = Tweet.find(params[:id])
    end

    def new
        @tweet = Tweet.new
    end

    def edit
        @tweet = Tweet.find(params[:id])
    end

    def create
        @user = User.find(session[:user_id])
        @tweet = @user.tweets.create(tweet_params)
    
        if @tweet.save
            redirect_to @tweet
        else
            render 'new'
        end
    end

    def update
        @tweet = Tweet.find(params[:id])

        if @tweet.update(tweet_params)
            redirect_to @tweet
        else
            render 'edit'
        end
    end

    def destroy
        @tweet = Tweet.find(params[:id])
        @tweet.destroy
        
        redirect_to tweets_path
    end

    private
    def tweet_params
        params.require(:tweet).permit(:content)
    end

    def sort_column
        params[:sort] || "created_at"
    end

    def sort_direction
        params[:direction] || "DESC"
    end
end