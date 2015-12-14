#day_5-2.rb

has_repeated_double = /(..).*\1/
has_repeated_letter = /(.).\1/

match_rules = [has_repeated_double, has_repeated_letter]
nice_count = 0

open(ARGV.shift).each_line do |line|
	nice_count += 1 if match_rules.map{ |rule| rule === line }.inject(:&)
end

puts nice_count
