require 'ostruct'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session,
        if: Proc.new { |c| c.request.format =~ %r{application/json} }
  helper_method :current_user

  def current_user 
    @current_user ||= Admins.find(session[:user_id]) if session[:user_id]
    if @current_user
      @current_user
    else
      OpenStruct.new(firstname: "Guest")
    end
  end

protected 
  def authenticate_user
    if session[:user_id]
       # set current user object to @current_user object variable
      @current_user = Admins.find(session[:user_id])
      return true	
    else
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'tools', :action => 'affiliates')
      return false
    else
      return true
    end
  end
end
