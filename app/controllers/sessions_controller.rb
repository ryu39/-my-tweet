class SessionsController < ApplicationController
  def new
    @form = ::Sessions::NewForm.new
  end

  def create
    @form = ::Sessions::NewForm.new(new_form_params)
    if @form.invalid?
      render :new and return
    end

    user = ::User.find_by(uid: @form.uid)
    unless user&.authenticate(@form.password)
      @form.errors.add(:base, :authentication_failed)
      render :new and return
    end

    reset_session
    session[:user_id] = user.id
    redirect_to tweets_path
  end

  def destroy
    # TODO
  end

  private

  def new_form_params
    params.require(:sessions_new_form).permit(:uid, :password)
  end
end
