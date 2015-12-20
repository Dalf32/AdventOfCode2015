#day_14-1.rb

class Reindeer
	def initialize(name, speed, fly_duration, rest_duration)
		@name = name
		@speed = speed
		@fly_duration = fly_duration
		@rest_duration = rest_duration
	end
	
	def get_distance_after_time(time)
		full_iters, remainder = time.divmod(@fly_duration + @rest_duration)
		
		total_distance = full_iters * @speed * @fly_duration
		total_distance += @speed * (remainder >= @fly_duration ? @fly_duration : remainder)
		
		total_distance
	end
	
	def to_s
		"#{@name} can fly #{@speed} km/s for #{@fly_duration} seconds, but then must rest for #{@rest_duration} seconds."
	end
end

race_time = 2503
reindeer = []

open(ARGV.shift).each_line do |line|
	name, *parts = line.chomp.split
	speed, fly_duration, rest_duration = parts.keep_if{ |part| /\d/ === part }.map(&:to_i)
	
	reindeer << Reindeer.new(name, speed, fly_duration, rest_duration)
end

puts reindeer.map{ |deer| deer.get_distance_after_time(race_time) }.max