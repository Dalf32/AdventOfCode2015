#day_11-1.rb

current_password = open(ARGV.shift).readlines.first.chomp

straights = ('a'..'x').map{ |first_letter| "#{first_letter}#{first_letter.next}#{first_letter.next.next}" }
prohibited_letters = ['i', 'o', 'l']
double_letters = /(.)\1/

while(true)
	current_password = current_password.next
	
	next unless straights.any?{ |straight| current_password.include?(straight) }
	next if prohibited_letters.any?{ |letter| current_password.include?(letter) }
	next unless current_password.scan(double_letters).size >= 2
	
	break
end

puts current_password
