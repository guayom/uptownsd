class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def disable_bullet
    Bullet.enable = false
  #   yield
  # ensure
  #   Bullet.enable = true
  end
end
