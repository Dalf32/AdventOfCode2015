#day_2-2.rb

total = 0

open(ARGV.shift).each_line do |line|
	sides = line.split('x')
	perimeter = sides.combination(2).to_a.map{ |(a, b)| (2 * a.to_i) + (2 * b.to_i) }.min
	total += sides.inject{ |side, product| side.to_i * product.to_i } + perimeter
end

puts total