require 'ostruct'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session,
        if: Proc.new { |c| c.request.format =~ %r{application/json} }
  helper_method :current_user

  def current_user
    @current_user ||= Users.find(session[:user_id]) if session[:user_id]
    if @current_user
      @current_user
    else
      OpenStruct.new(name: "Guest")
    end
  end
end
