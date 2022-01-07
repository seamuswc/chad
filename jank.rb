
def parse()
    
    data = api()
    data.each do |x|   
        next if x["last_sale"].nil?  
        if x["asset_contract"]["asset_contract_type"] != "non-fungible"
            $total_nfts +=1
            next
        end
        slug =  x["collection"]["slug"] 
        floor = get_floor(slug)
        last_price= x["last_sale"]["total_price"].to_f / 1000000000000000000
        puts "#{x["asset_contract"]["name"]} was purchased for #{last_price} and has a current floor price of #{floor} ETH"  
        $total_floor += floor
        $total_paid += last_price 
        $total_nfts +=1
        $non_mints += 1

    end

end

def mints()
    
    data = api_mints()
    data.each do |x|   

        if x["asset_contract"]["asset_contract_type"] != "non-fungible"
            $total_nfts +=1
            next
        end
        slug =  x["collection"]["slug"] 
        floor = get_floor(slug)

        if x["last_sale"].nil?
            puts "#{x["asset_contract"]["name"]} was Minted and has a current floor price of #{floor} ETH"  
        end
        $total_floor += floor
        $total_nfts +=1
        $mints += 1

    end

end

def api_mints()

    url = URI("https://api.opensea.io/api/v1/assets?owner=#{$wallet}&limit=50&order_by=sale_count&order_direction=asc")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)

    res = http.request(request)

    if res.code == "200"
        parsed = JSON.parse(res.body)
        return parsed["assets"]
    else
        puts "couldnt find nft"
        puts res.code
    end

end

def api()

    #purchased
    url = URI("https://api.opensea.io/api/v1/assets?owner=#{$wallet}&limit=50&order_by=sale_price&order_direction=desc")
    
    #mints
    #url = URI("https://api.opensea.io/api/v1/assets?owner=#{$wallet}&limit=50&order_by=sale_count&order_direction=asc")



    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)

    res = http.request(request)

    if res.code == "200"
        parsed = JSON.parse(res.body)
        return parsed["assets"]
    else
        puts "couldnt find nft"
    end

end
