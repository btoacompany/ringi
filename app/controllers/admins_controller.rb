#coding:utf-8

class AdminsController < ApplicationController
  before_filter :authenticate_admin, :except => [:login, :login_complete, :logout,
  :create,:create_complete]

  def login
    if session[:admin_id]
      redirect_to "/tools/history"
    end
  end

  def login_complete
    authorized_admin = Admins.authenticate(params[:username],params[:password])
    reset_session
    if authorized_admin
      session[:admin_id] = authorized_admin.id
      flash[:notice] = "" 
      redirect_to "/tools/history"
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end

  def logout
    session[:admin_id] = nil
    reset_session
    redirect_to '/tools/login'
  end

  def index
  end

  def create
    #do nothing
=begin    
    if (@current_user.admin_type == 0)
      redirect_to '/tools'
    end
=end    
  end

  def create_complete
    admin = Admins.new
    admin.save_record(params)
    redirect_to_index
  end

  def edit
  end

  def edit_complete
  end

  def redirect_to_index
    redirect_to "/tools" 
  end
end
