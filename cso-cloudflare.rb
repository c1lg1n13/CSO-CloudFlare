#!/usr/bin/env ruby
# encoding: UTF-8
require 'net/http'
require 'open-uri'
require 'json'
require 'socket'
require 'optparse'

def banner()
red = "\033[01;31m"
green = "\033[01;32m"

puts "\n"
puts" ██████╗███████╗ ██████╗ ██╗   ██╗██╗   ██╗███╗   ██╗ ██████╗██╗   ██╗"
puts"██╔════╝██╔════╝██╔═══██╗╚██╗ ██╔╝██║   ██║████╗  ██║██╔════╝██║   ██║"
puts"██║     ███████╗██║   ██║ ╚████╔╝ ██║   ██║██╔██╗ ██║██║     ██║   ██║"
puts"██║     ╚════██║██║   ██║  ╚██╔╝  ██║   ██║██║╚██╗██║██║     ██║   ██║"
puts"╚██████╗███████║╚██████╔╝   ██║   ╚██████╔╝██║ ╚████║╚██████╗╚██████╔╝"
puts" ╚═════╝╚══════╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ "
                                                                      


                                                              




puts "#{red}CloudFlare korumali web sitesinin gercek IP'sini tanimlama scripti."
puts "[ CSOYUNCU ONLINE OYUN SUNUCULARI ]"
puts "www.csoyuncu.net - www.csoyuncu.com"

puts "\n"
end

options = {:bypass => nil, :massbypass => nil}
parser = OptionParser.new do|opts|

    opts.banner = "Ornek: ruby cso-cloudflare.rb -b <hedef site> or ruby cso-cloudflare.rb --byp <hedef site>"
    opts.on('-b ','--byp ', 'Gercek IP adresini keşfedin (CloudFlare korumasini bypass edin.)', String)do |bypass|
    options[:bypass]=bypass;
    end

    opts.on('-o', '--out', 'Sonraki Surum.', String) do |massbypass|
        options[:massbypass]=massbypass

    end

    opts.on('-h', '--help', 'Help') do
        banner()
        puts opts
        puts "Ornek: ruby cso-cloudflare.rb -b csduragi.com or ruby cso-cloudflare.rb --byp csduragi.com"
        exit
    end
end

parser.parse!


banner()

if options[:bypass].nil?
    puts "-b hedef site yada --byp"
else
	option = options[:bypass]
	payload = URI ("http://www.crimeflare.org/cgi-bin/cfsearch.cgi")
	request = Net::HTTP.post_form(payload, 'cfS' => options[:bypass])

	response =  request.body
	nscheck = /Calısan kayitli bir isim sunucusu yok/.match(response)
	if( !nscheck.nil? )
		puts "[-] Gecerli adres yok - bunun bir CloudFlare korumali alan oldugundan emin misiniz?\n"
		exit
	end
	regex = /(\d*\.\d*\.\d*\.\d*)/.match(response)
	if( regex.nil? || regex == "" )
		puts "[-] Gecerli adres yok - bunun bir CloudFlare korumali alan oldugundan emin misiniz?\n"
		puts "[-] Alternatif olarak, crimeflare.org çoktu mu? Elle deneyin.\n"
		exit
	end
	ip_real = IPSocket.getaddress (options[:bypass])

	puts "[+] Site analizi: #{option} "
	puts "[+] CloudFlare IP #{ip_real} "
	puts "[+] Gercek IP #{regex}"
	target = "http://ipinfo.io/#{regex}/json"
	url = URI(target).read
	json = JSON.parse(url)
	puts "[+] Alan Adı: " + json['hostname']
	puts "[+] Sehir: "  + json['city']
	puts "[+] Ulke: " + json['country']
	puts "[+] Konum: " + json['loc']
	puts "[+] Organizasyon: " + json['org']

end
