class Affiliates < ActiveRecord::Base
  self.table_name = "affiliates"

  before_create :set_create_time
  before_update :set_update_time
  
  def save_record(params)
    self.name	      = params[:name]
    self.link	      = params[:link]
    self.instructions = params[:instructions]
    self.price_tax    = params[:price_tax]
    self.price_discount_tax = params[:price_discount_tax]
    self.status	      = params[:status]
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
