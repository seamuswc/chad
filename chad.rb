require 'uri'
require 'net/http'
require 'openssl'
require 'json'

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

def api_final()

    url = URI("https://api.opensea.io/api/v1/assets?owner=#{$wallet}&limit=50")

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

def parse_final()
    
    data = api_final()
    data.each do |x|  
        
        if x["asset_contract"]["asset_contract_type"] != "non-fungible"
            puts "#{x["asset_contract"]["name"]} is FUNGIBLE and it's price not counted"  
            $total_nfts +=1
            $fungibles +=1
            next
        end

        slug =  x["collection"]["slug"] 
        floor = get_floor(slug)

        if x["last_sale"].nil?  
            puts "#{x["asset_contract"]["name"]} was Minted and has a current floor price of #{floor} ETH"  
            $mints += 1       
        else
            last_price= x["last_sale"]["total_price"].to_f / 1000000000000000000
            puts "#{x["asset_contract"]["name"]} was purchased for #{last_price} and has a current floor price of #{floor} ETH"  
            $total_paid += last_price 
            $non_mints += 1
        end


        $total_floor += floor
        $total_nfts +=1
        
    end

end

$total_floor = 0
$total_paid = 0
$total_nfts = 0
$mints = 0
$non_mints = 0
$fungibles = 0

puts "Enter address\n"
$wallet = gets.chomp

parse_final()

puts
puts "This wallet spent a total of #{$total_paid} ETH on the NFT's inside it and has a total NFT worth of #{$total_floor} ETH"
puts
puts "This program found #{$total_nfts} NFTS, the max is 50. There might be more if you hit 50!"
puts
puts "#{$mints} Minted, #{$non_mints} Purchased, #{$fungibles} fungibles were found"
puts