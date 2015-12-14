#day_1-2.rb

BASEMENT = -1
current_floor = 0
index = 0

open(ARGV.shift).each_char do |char|
	index += 1
	current_floor += char == '(' ? 1 : -1
	
	break if current_floor == BASEMENT
end

puts index
