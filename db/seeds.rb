::ActiveRecord::Base.transaction do
  user = ::User.create!(uid: 'test', password: 'password', password_confirmation: 'password')

  user.tweets << ::Tweet.new(text: 'Hello my-tweet')
  user.tweets << ::Tweet.new(text: 'My goal is Twitter!!', url: 'https://twitter.com')

  app = ::Doorkeeper::Application.new(name: 'MyTweet App', redirect_uri: 'http://localhost:3000/oauth/callback')
  app.uid = 'uid'
  app.secret = 'secret'
  app.save!
end
