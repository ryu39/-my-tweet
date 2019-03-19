class ApplicationController < ActionController::Base
  def user_must_be_authenticated
    @user = ::User.find_by(id: session[:user_id])
    if @user.nil?
      redirect_to new_session_path
    end
  end
end
