class Users < ActiveRecord::Base
  self.table_name = "users"

  before_create :set_create_time
  before_update :set_update_time
  
  def save_record(params)
    self.firstname    = params[:firstname]
    self.lastname     = params[:lastname]
    self.email	      = params[:email]
    self.password     = params[:password]
    self.gender	      = params[:gender]
    self.organization = params[:organization]
    self.department   = params[:department]
    self.user_group   = params[:user_group]
    self.user_type    = params[:user_type]
    self.save
  end
  
  def delete_record
    self.delete_flag = 1
    self.save
  end

  def set_create_time 
    t = set_time
    self.create_time = t
    self.update_time = t
  end

  def set_update_time 
    t = set_time
    self.update_time = t
  end

  def set_time
    return Time.now.strftime("%Y-%m-%d %H:%M:%S")
  end
end
