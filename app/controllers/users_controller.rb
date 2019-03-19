class UsersController < ApplicationController
  before_action :user_must_be_authenticated
  before_action :user_must_be_admin_user

  def new
  end

  def create
    ActiveRecord::Base.transaction do
      id = Random.rand(99999).to_s.rjust(5, '0')
      user = User.create!(uid: 'recruit_' + id, password: 'password')
      user.tweets << Tweet.new(text: 'ユニファ株式会社', url: 'https://unifa-e.com')

      app = Doorkeeper::Application.create!(name: 'MyTweetApp',
                                            redirect_uri: 'http://localhost:3000/oauth/callback',
                                            confidential: false)

      render json: {
        user_id: user.uid,
        user_password: 'password',
        client_id: app.uid,
        client_secret: app.secret,
      }
    end
  end

  private

  def user_must_be_admin_user
    unless @user.admin?
      render plain: 'Forbidden', status: 403
    end
  end
end
