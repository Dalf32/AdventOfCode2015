#day_3-2.rb

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

def next_turn(cur_turn)
	case(cur_turn)
		when :santa
			:robo_santa
		when :robo_santa
			:santa
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

current_turn = :santa
santa_house = House.new(0, 0)
robo_santa_house = santa_house
visited_houses = [santa_house].to_set

open(ARGV.shift).each_char do |char|
	current_house = case(current_turn)
		when :santa
			santa_house = process_direction(char, santa_house)
		when :robo_santa
			robo_santa_house = process_direction(char, robo_santa_house)
	end
	
	visited_houses<<current_house
	current_turn = next_turn(current_turn)
end

puts visited_houses.count
