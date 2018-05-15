class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'ログインが必要なページです'
        redirect_to root_url
      end
    end
end
