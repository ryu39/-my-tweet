module Api
  class TweetsController < ::Api::ApplicationController
    before_action :doorkeeper_authorize!
    before_action :set_user
    before_action :set_tweet, only: [:show, :update, :destroy]

    def index
      @tweets = @user.tweets
      render json: @tweets
    end

    def show
      render json: @tweet
    end

    def create
      @tweet = ::Tweet.new(tweet_params)
      @user.tweets << @tweet

      render json: @tweet, status: 201
    end

    def update
      @tweet.assign_attributes(tweet_params)
      @tweet.save!

      render json: @tweet
    end

    def destroy
      @tweet.destroy

      head :no_content
    end

    private

    def set_user
      @user = ::User.find(doorkeeper_token.resource_owner_id)
    end

    def set_tweet
      @tweet = @user.tweets.find(params[:id])
    end

    def tweet_params
      params.permit(:text, :url)
    end
  end
end
