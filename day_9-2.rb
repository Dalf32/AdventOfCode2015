#day_9-2.rb

class Location
	attr_reader :name

	def initialize(name)
		@name = name
		@distances = {}
	end
	
	def add_distance(other_location, distance)
		@distances[other_location] = distance
	end
	
	def find_shortest_path(locations)
		find_shortest_path_recursive(locations, [@name])
	end
	
	def to_s
		"#{@name}: #{@distances.to_s}"
	end
	
	def eql?(other_loc)
		@name.eql?(other_loc.name)
	end
	
	def hash
		@name.hash
	end
	
	protected
	
	def find_shortest_path_recursive(locations, visited_locations)
		locations_left = @distances.keys - visited_locations
		
		return @distances[locations_left.first] if locations_left.count == 1
		
		locations_left.map{ |loc| locations[loc].find_shortest_path_recursive(locations, visited_locations + [loc]) + @distances[loc] }.max
	end
end

locations = Hash.new{ |hash, loc_name| hash[loc_name] = Location.new(loc_name) }

open(ARGV.shift).each_line do |line|
	line, distance = line.chomp.split(' = ')
	start_loc, end_loc = line.split(' to ')

	locations[start_loc].add_distance(end_loc, distance.to_i)
	locations[end_loc].add_distance(start_loc, distance.to_i)
end

puts locations.values.map{ |location| location.find_shortest_path(locations) }.max
