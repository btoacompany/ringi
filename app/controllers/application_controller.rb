require 'ostruct'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session,
        if: Proc.new { |c| c.request.format =~ %r{application/json} }
  helper_method :current_user

  Rails::logger.debug "-----hello world!-----"
  def current_user
    @current_user||= Admins.find(session[:admin_id]) if session[:admin_id]
    @current_user||= Users.find(session[:user_id]) if session[:user_id]

    if @current_user
      @current_user
    else
      OpenStruct.new(firstname: "Guest")
    end
  end

protected 
  def authenticate_admin
    if session[:admin_id]
      # set current admin object to @current_user object variable
      @current_user = Admins.find(session[:admin_id])
      return true	
    else
      redirect_to "/tools/login"
      return false
    end
  end

  def authenticate_user
    if session[:user_id]
      # set current user object to @current_user object variable
      @current_user = Users.find(session[:user_id])
      return true	
    else
      redirect_to "/ringi/login"
      return false
    end
  end

  def save_login_state
    if session[:admin_id]
      redirect_to(:controller => 'history', :action => 'index')
      return false
    elsif session[:user_id]
      redirect_to(:controller => 'ringi', :action => 'index')
      return false
    else
      return true
    end
  end
end
