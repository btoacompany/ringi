#coding:utf-8
require 'cgi'

class RingiController < ApplicationController
  include Crawler 

  def index
    @sites = Affiliates.where(:delete_flag => 0, :status => 1)
  end

  def info
    @site_id = params[:site_id].to_i
    @site = Affiliates.find(@site_id)
    @url = CGI.unescape(params[:url])
    @infos = get_site_info(@site_id, params[:url]) 
  end

  def create_email
    unless session[:user].present?
      params[:user_id] = 0
      params[:user_type] = 0
    end

    site = Affiliates.find(params[:site_id])
    
    tax = 0
    params[:price] = price = str_to_int(params[:price])
    params[:price_discount] = price_discount = str_to_int(params[:price_discount])

    if price_discount > 0
      price = price_discount 
      tax = 0.08 if site[:price_discount_tax] == 0
    else
      tax = 0.08 if site[:price_tax] == 0
    end

    tax = price * tax 
    params[:price] = (price + tax).round
    params[:price_total] = params[:price] * params[:qty].to_i 

    history = History.new
    history.save_record(params)
  end

  def complete 
    redirect_to_index
  end

  def str_to_int(str)
    str.scan(/\d/).join('').to_i
  end

  def redirect_to_index
    redirect_to "/ringi" 
  end
end
