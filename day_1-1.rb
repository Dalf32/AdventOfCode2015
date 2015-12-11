#day_1-1.rb

current_floor = 0

open(ARGV.shift).each_char do |char|
	current_floor += char == '(' ? 1 : -1
end

puts current_floor
