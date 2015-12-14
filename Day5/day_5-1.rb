#day_5-1.rb

has_three_vowels = /(.*[aeiou].*){3}/
has_double_letters = /(.)\1/
doesnt_have_strings = /^(?!.*(ab|cd|pq|xy)).*$/
match_rules = [has_three_vowels, has_double_letters, doesnt_have_strings]
nice_count = 0

open(ARGV.shift).each_line do |line|
	nice_count += 1 if match_rules.map{ |rule| rule === line }.inject(:&)
end

puts nice_count
