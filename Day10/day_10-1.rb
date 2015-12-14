#day_10-1.rb

sequence = open(ARGV.shift).readlines.first.chomp

40.times do
	current_char = sequence.chars.first
	repeat_count = 0
	new_sequence = ''

	sequence.chars.each do |char|
		if char == current_char
			repeat_count += 1
		else
			new_sequence << repeat_count.to_s + current_char
			current_char = char
			repeat_count = 1
		end
	end
	
	new_sequence << repeat_count.to_s + current_char
	sequence = new_sequence
end

puts sequence.length
