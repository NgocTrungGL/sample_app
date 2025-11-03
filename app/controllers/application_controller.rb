class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_locale
  def set_locale
    I18n.locale = :en
  end

  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = "Please log in."
    redirect_to login_path
  end
end
