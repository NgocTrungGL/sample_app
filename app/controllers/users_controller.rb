class UsersController < ApplicationController
  before_action :set_user,
                only: %i(show edit update destroy following followers)
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy(User.all, items: Settings.page_10)
  end

  def show
    unless @user
      flash[:warning] = t(".user not found!")
      redirect_to root_path and return
    end

    @pagy, @microposts = pagy(@user.microposts, items: Settings.page_10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t(".please check your email to activate your account.")
      redirect_to root_url, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t(".profile updated")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t(".user deleted")
    else
      flash[:danger] = t(".delete failed!")
    end
    redirect_to users_path
  end

  def following
    @title = t(".following")
    @pagy, @users = pagy(@user.following, items: Settings.page_10)
    render :show_follow
  end

  def followers
    @title = t(".followers")
    @pagy, @users = pagy(@user.followers, items: Settings.page_10)
    render :show_follow
  end

  private
  def set_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:danger] = t(".user not found!")
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t(".please log in.")
    redirect_to login_url
  end

  def correct_user
    return if current_user?(@user)

    redirect_to(root_url,
                flash: {error: t(".you cannot edit this account.")})
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
