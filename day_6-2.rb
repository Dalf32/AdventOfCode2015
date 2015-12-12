#day_6-2.rb

def fill_range(ary, range_start, range_end, &block)
	col_range = range_start.last..range_end.last
	row_range = range_start.first..range_end.first

	ary[col_range].each{ |row| row[row_range] = row[row_range].map(&block) }
end

def toggle(lights, range_start, range_end)
	fill_range(lights, range_start, range_end){ |light| light + 2 }
end

def turn_on(lights, range_start, range_end)
	fill_range(lights, range_start, range_end){ |light| light + 1 }
end

def turn_off(lights, range_start, range_end)
	fill_range(lights, range_start, range_end){ |light| [light - 1, 0].max }
end

lights = Array.new(1000){ Array.new(1000).fill(0) }

open(ARGV.shift).each_line do |line|
	ranges = line[(/\d/ =~ line)..-1].split(' through ')
	range_start = ranges.first.split(',').map(&:to_i)
	range_end = ranges.last.split(',').map(&:to_i)
	
	case(line)
		when /toggle/
			toggle(lights, range_start, range_end)
		when /turn on/
			turn_on(lights, range_start, range_end)
		when /turn off/
			turn_off(lights, range_start, range_end)
	end
end

puts lights.flatten.inject(0, :+)
