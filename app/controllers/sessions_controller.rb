class SessionsController < ApplicationController
  def new; end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  def create
    user = find_user
    if authenticated?(user)
      successful_login(user)
    else
      failed_login
    end
  end

  private

  def find_user
    User.find_by(email: params.dig(:session, :email)&.downcase)
  end

  def authenticated? user
    user&.authenticate(params.dig(:session, :password))
  end

  def successful_login user
    forwarding_url = session[:forwarding_url]
    reset_session
    log_in user
    params.dig(:session, :remember_me) == "1" ? remember(user) : forget(user)
    redirect_to forwarding_url || user
  end

  def failed_login
    flash.now[:danger] = t "invalid_email_password_combination"
    render :new, status: :unprocessable_entity
  end
end
