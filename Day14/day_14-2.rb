#day_14-2.rb

class Reindeer
	attr_reader :current_distance, :points

	def initialize(name, speed, fly_duration, rest_duration)
		@name = name
		@speed = speed
		@fly_duration = fly_duration
		@rest_duration = rest_duration
		@current_distance = 0
		@points = 0
		@status = :flying
		@status_elapsed = 0
	end
	
	def tick
		@status_elapsed += 1
		
		if @status == :flying
			fly
		else
			rest
		end
	end
	
	def award_point
		@points += 1
	end
	
	def to_s
		"#{@name} can fly #{@speed} km/s for #{@fly_duration} seconds, but then must rest for #{@rest_duration} seconds."
	end
	
	private
	
	def fly
		@current_distance += @speed
		
		if @status_elapsed == @fly_duration
			@status = :resting
			@status_elapsed = 0
		end
	end
	
	def rest
		if @status_elapsed == @rest_duration
			@status = :flying
			@status_elapsed = 0
		end
	end
end

race_time = 2503
reindeer = []

open(ARGV.shift).each_line do |line|
	name, *parts = line.chomp.split
	speed, fly_duration, rest_duration = parts.keep_if{ |part| /\d/ === part }.map(&:to_i)
	
	reindeer << Reindeer.new(name, speed, fly_duration, rest_duration)
end

race_time.times do |n|
	reindeer.each(&:tick)
	max_dist = reindeer.map(&:current_distance).max
	
	reindeer.each{ |deer| deer.award_point if deer.current_distance == max_dist }
end

puts reindeer.map{ |deer| deer.points }.max
