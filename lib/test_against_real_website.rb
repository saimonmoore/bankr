require 'rubygems'
require 'nokogiri'
require 'mechanize'

require 'bankr/bankr'
require 'bankr/account'
require 'bankr/movement'

VALID_DATA = YAML.load( File.open('../spec/support/valid_data.yml') )

a = Bankr::Scrapers::LaCaixa.new(:login => VALID_DATA["login"], :password => VALID_DATA["password"])

puts "LaCaixa Scraper Live Test"
puts "Logging in...."
a.log_in
puts "...ok"

puts "Fetching accounts...."
accounts = a.accounts
puts "...ok. #{accounts.size} accounts found."

puts "Fetching first account..."
first_account = accounts[0]
puts "...ok" unless first_account.nil?

puts "Fetching movements for the last 6 days..."
movements = a._movements_for(first_account, :last => 6.days)
puts "...ok. Fetched #{movements.size} movements." unless movements.empty? or movements.nil?

puts "Just for the record, your last movement looks like this:"
pp movements.last
