#coding:utf-8

class AffiliatesController < ApplicationController
  before_filter :init

  def init
  end

  def index
    @sites = Affiliates.where(:delete_flag => 0)
  end

  def create
    #do nothing
  end

  def create_complete
    sites = Affiliates.new
    sites.save_record(params)
    redirect_to_index 
  end

  def edit
    @sites = Affiliates.find(params[:id])
  end
  
  def edit_complete
    sites = Affiliates.find(params[:id])
    sites .save_record(params)
    history = History.where(:affiliate_id => sites.id).update_all(:affiliate_name => sites.name)
    redirect_to_index 
  end

  def delete_complete
    sites = Affiliates.find(params[:id])
    sites.delete_record
    redirect_to_index 
  end

  def redirect_to_index
    redirect_to "/tools/affiliates" 
  end
end
