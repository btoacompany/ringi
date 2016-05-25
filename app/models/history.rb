class History < ActiveRecord::Base
  self.table_name = "history"

  before_create :set_create_time
  before_update :set_update_time
  
  def save_record(params)
    self.user_id	= params[:user_id]
    self.user_type	= params[:user_type]
    self.url		= params[:url]
    self.affiliate_id	= params[:site_id]
    self.affiliate_name = params[:site_name]
    self.price		= params[:price]
    self.price_total	= params[:price_total]
    self.qty		= params[:qty]
    self.qty_info	= params[:qty_info]
    self.sku_id		= params[:sku_id]
    self.title		= params[:title]
    self.purpose	= params[:purpose]
    self.notes		= params[:notes]
    self.status		= 0 
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
