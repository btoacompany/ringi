class Amazon
include Crawler

def parse_amazon(url)
  @xpaths = {
    :title	    => ["//span[@id='productTitle']"],
    :maker	    => ["//a[@id='brand']"],
    :price	    => ["//span[@id='priceblock_ourprice']"],
    :sku_id	    => [""],
    :qty	    => [""]
  }

  parse_url(@xpaths, url)
  return @infos
end

end
