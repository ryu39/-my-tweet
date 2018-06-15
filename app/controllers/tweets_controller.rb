class TweetsController < ApplicationController
  before_action :user_must_be_authenticated

  def index
    @tweets = @user.tweets
  end

  private

  def user_must_be_authenticated
    @user = ::User.find_by(id: session[:user_id])
    if @user.nil?
      redirect_to new_session_path
    end
  end
end
