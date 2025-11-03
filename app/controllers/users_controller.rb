class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  def show
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:warning] = "User not found!"
      redirect_to root_path and return
    end

    @page, @microposts = pagy(
      @user.microposts,
      items: Settings.page_10
    )
  end

  def index
    @pagy, @users = pagy(User.all, items: 10)
  end

  def new
    @user = User.new
  end

  def destroy
    if @user.destroy
      flash[:success] = "User deleted"
    else
      flash[:danger] = "Delete fail!"
    end
    redirect_to users_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end
  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = "User not found!"
    redirect_to root_url
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = "You cannot edit this account."
    redirect_to root_url
  end
end
