class TweetsController < ApplicationController
  before_action :user_must_be_authenticated

  def index
    @tweets = @user.tweets
  end
end
