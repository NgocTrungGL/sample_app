class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_locale
  def set_locale
    I18n.locale = :en
  end

  protect_from_forgery with: :exception
  include SessionsHelper
end
