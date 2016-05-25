class Monotaro
  extend Crawler
  @xpaths = {
    :title	    => ["//h1[@class='itd_prodname']//span[@class='fn']"],
    :sku_id	    => ["//dl[@class='itd_info_dl']/dd[2]"],
    :maker	    => ["//span[@class='itd_brand']//strong","//span[@class='itd_brand']//img/@title"],
    :price	    => ["//table[@class='itd_price_table']//b"],
    :qty	    => ["//dl[@class='itd_info_dl']/dd[3]"]
  }

  parse_url(@xpaths, url)
  return @infos
end
