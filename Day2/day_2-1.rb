#day_2-1.rb

total = 0

open(ARGV.shift).each_line do |line|
	sides = line.split('x').combination(2).to_a.map{ |(a, b)| a.to_i*b.to_i }
	total += (2 * sides.inject{ |side, sum| side + sum }) + sides.min
end

puts total