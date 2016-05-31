#coding:utf-8
require 'nokogiri'
require 'open-uri'

module Crawler 
  def parse_url(xpaths, url)
    begin
      doc = Nokogiri::HTML(open(url))
      doc.encoding = "utf-8"
      xpaths.each do | key, elements |
	elements.each do | elem |
	  if elem.present?
	    if doc.xpath(elem).present?
	      @infos[key] = doc.xpath(elem).first.inner_text.strip
	      break
	    end
	  else
	    @infos[key] = elem.strip 
	    break
	  end
	end
      end

      @infos[:price] = extract_integer(@infos[:price])
      @infos[:qty] = "1個" if @infos[:qty].blank?

    rescue Exception => e
      puts e.message
    end
  end

  def extract_integer(str)
    str.scan(/\d/).join('')
  end

  def get_site_info(site_name, url)
    url = URI.escape(url)
    @xpaths = {}
    @infos = {}

    case site_name
    when 'Monotaro'
      parse_monotaro(url)
    when 'Askul' 
      parse_askul(url)
    when 'Lohaco' 
      parse_lohaco(url)
    end
  end

private
  def parse_monotaro(url)
    @xpaths = {
      :title	    => ["//h1[@class='itd_prodname']//span[@class='fn']"],
      :sku_id	    => ["//dl[@class='itd_info_dl']/dd[2]"],
      :maker	    => ["//span[@class='itd_brand']//strong","//span[@class='itd_brand']//img/@title"],
      :price	    => ["//dl[@class='itd_info_dl']/dt[contains(text(),'税込')]/following-sibling::dd","//table[@class='price_Table']//th[contains(text(),'税込')]/following-sibling::td"],
      :qty	    => ["//dl[@class='itd_info_dl']/dd[3]"],
      :price_discount => [""]
    }

    parse_url(@xpaths, url)
    return @infos
  end

  def parse_askul(url)
    @xpaths = {
      :title	    => ["//h1[@itemprop='name']"],
      :sku_id	    => ["//span[@itemprop='mpn']"],
      :maker	    => ["//div[@class='Maker_label']//li[2]/a"],
      :price	    => ["//table[@class='price_Table']//tr[2]/td"],
      :qty	    => ["//div[@class='Other_Info']//li[3]/span/text()"],
      :price_discount => [""]
    }

    parse_url(@xpaths, url)
    return @infos
  end

  def parse_lohaco(url)
    @xpaths = {
      :title	    => ["//h1[@itemprop='name']"],
      :price	    => ["//div[@class='price']//span[@class='sellPrice']"],
      :qty	    => ["//div[@class='cp-product_itemInfoSalesUnit']//span[@class='salesUnit']/span"],
      :sku_id	    => [""],
      :maker	    => [""],
      :price_discount => [""]
    }

    parse_url(@xpaths, url)
    return @infos
  end

=begin
  def parse_askul(url)
    @xpaths = {
      :title	    => [""],
      :sku_id	    => [""],
      :maker	    => [""],
      :price	    => [""],
      :qty	    => [""],
      :price_discount => [""]
    }

    parse_url(@xpaths, url)
    return @infos
  end
=end  
end
