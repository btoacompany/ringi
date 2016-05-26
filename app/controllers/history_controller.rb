#coding:utf-8

class HistoryController < ApplicationController
  before_filter :authenticate_admin

  def index
    @history = History.where(:delete_flag => 0).order("create_time DESC")
    @total_purchase = @history.sum(:price_total)
  end
end
