require 'uri'
require 'net/http'
require 'openssl'
require 'json'

def api()

    
    #url = URI("https://api.opensea.io/api/v1/assets?owner=0xBbcFa939071D2A0BF64D8E15a715C0BE73735503&limit=50&order_by=sale_price&order_direction=desc")

    url = URI("https://api.opensea.io/api/v1/assets?owner=#{$wallet}&limit=50&order_by=sale_price&order_direction=desc")

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

def get_floor(nft) 
    
    url = URI("https://api.opensea.io/collection/#{nft}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    res = http.request(request)

    if res.code == "200"
        parsed = JSON.parse(res.body)
        return parsed["collection"]["stats"]["floor_price"]
    else
        puts "couldnt find nft"
    end

end


def parse()
    
    data = api()
    data.each do |x|   
        next unless x["asset_contract"]["asset_contract_type"]["non-fungible"]
        next if x["last_sale"].nil?  
        slug =  x["collection"]["slug"] 
        floor = get_floor(slug)
        last_price= x["last_sale"]["total_price"].to_f / 1000000000000000000
        puts "#{x["asset_contract"]["name"]} was purchased for #{last_price} and has a current floor price of #{floor} ETH"  
        $total_floor += floor
        $total_paid += last_price 
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

def mints()
    
    data = api_mints()
    data.each do |x|   

        next unless x["asset_contract"]["asset_contract_type"]["non-fungible"]

        slug =  x["collection"]["slug"] 
        floor = get_floor(slug)

        if x["last_sale"].nil?
            puts "#{x["asset_contract"]["name"]} was Minted and has a current floor price of #{floor} ETH"  
        end
        $total_floor += floor

    end

end

$total_floor = 0
$total_paid = 0

puts "Enter address\n"
$wallet = gets.chomp

parse()
mints()

puts "This wallet spend a total of #{$total_paid} and is worth a total of #{$total_floor} on NFT's currently in the wallet"
