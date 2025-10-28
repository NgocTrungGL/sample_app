class SessionsController < ApplicationController
  def new; end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  def create
    @user = find_user

    if @user&.authenticate(params[:session][:password])
      handle_authenticated_user(@user)
    else
      handle_invalid_login
    end
  end

  private

  def find_user
    email = params.dig(:session, :email)&.downcase
    User.find_by(email:)
  end

  def handle_authenticated_user user
    if user.activated?
      successful_login(user)
    else
      handle_unactivated_user
    end
  end

  def successful_login user
    forwarding_url = session[:forwarding_url]
    reset_session
    remember_or_forget(user)
    log_in user
    redirect_to(forwarding_url || user)
  end

  def remember_or_forget user
    if params[:session][:remember_me] == "1"
      remember(user)
    else
      forget(user)
    end
  end

  def handle_unactivated_user
    flash[:warning] = "Account not activated.
    Check your email for the activation link."
    redirect_to root_url, status: :see_other
  end

  def handle_invalid_login
    flash.now[:danger] = "Invalid email/password combination"
    render "new", status: :unprocessable_entity
  end
end
