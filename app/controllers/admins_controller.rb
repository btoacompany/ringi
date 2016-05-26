#coding:utf-8

class AdminsController < ApplicationController
  def login
  end

  def login_complete
    authorized_user = Admins.authenticate(params[:username],params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Welcome again, you logged in as #{authorized_user.username}"
      redirect_to '/tools/affiliates'
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "/tools/login"	
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/tools/login'
  end

  def index
  end

  def create
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
    redirect_to "/tools/register" 
  end
end
