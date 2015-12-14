#day_4-2.rb

require 'digest'

Infinity = 1.0 / 0.0
MatchRegex = /^000000\d*/

secret = open(ARGV.shift).readline
current_key_num = 0

(1..Infinity).each do |key_num|
	current_key_num = key_num
	break if MatchRegex === Digest::MD5.hexdigest(secret + key_num.to_s)
end

puts current_key_num
