#day_13-2.rb

class Guest
	attr_reader :name

	def initialize(name)
		@name = name
		@preferences = {}
	end
	
	def add_preference(other_guest, delta_happiness)
		@preferences[other_guest] = delta_happiness
	end
	
	def ranked_preferences
		@preferences.sort{ |pref1, pref2| pref2[1] <=> pref1[1] }
	end
	
	def preference_for(other_guest)
		@preferences[other_guest]
	end
	
	def to_s
		"#{@name}: #{ranked_preferences}"
	end
end

class GuestList
	def initialize
		@guests = Hash.new{ |hash, guest_name| hash[guest_name] = Guest.new(guest_name) }
	end
	
	def add_preference_for(guest, neighbor, preference)
		@guests[guest].add_preference(neighbor, preference)
	end
	
	def list
		@guests.keys
	end
	
	def count
		@guests.count
	end
	
	def [](guest)
		@guests[guest]
	end
	
	def get_happiness_for_seating(seating)
		total_happiness = 0
		
		(0..(seating.count - 1)).each{ |n|
			guest1 = @guests[seating[n]]
			guest2 = @guests[seating[n - 1]]
			
			total_happiness += guest1.preference_for(guest2.name) + guest2.preference_for(guest1.name)
		}
		
		total_happiness
	end
	
	def to_s
		@guests.to_s
	end
end

guests = GuestList.new

open(ARGV.shift).each_line do |line|
	delta_happiness = line.scan(/\d+/).first.to_i
	guest, preference = line.chomp.chomp('.').split(' ').values_at(0, -1)
	
	case(line)
		when /gain/
			guests.add_preference_for(guest, preference, delta_happiness)
		when /lose/
			guests.add_preference_for(guest, preference, -delta_happiness)
	end
end

new_guest = 'Santa'

guests.list.each do |other_guest|
	guests.add_preference_for(new_guest, other_guest, 0)
	guests.add_preference_for(other_guest, new_guest, 0)
end

puts guests.list.permutation(guests.count).map{ |seating| guests.get_happiness_for_seating(seating) }.max
