#day_3-1.rb

require 'set'

class House
	attr_reader :x, :y
	
	def initialize(x, y)
		@x, @y = x, y
	end
	
	def north
		House.new(@x + 1, @y)
	end
	
	def south
		House.new(@x - 1, @y)
	end
	
	def east
		House.new(@x, @y + 1)
	end
	
	def west
		House.new(@x, @y - 1)
	end
	
	def eql?(other_house)
		@x == other_house.x && @y == other_house.y
	end
	
	def hash
		[@x, @y].hash
	end
end

def process_direction(direction, house)
	case(direction)
		when '^'
			house.north
		when 'v'
			house.south
		when '>'
			house.east
		when '<'
			house.west
	end
end

current_house = House.new(0, 0)
visited_houses = [current_house].to_set

open(ARGV.shift).each_char do |char|
	current_house = process_direction(char, current_house)
	visited_houses<<current_house
end

puts visited_houses.count
