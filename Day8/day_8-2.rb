#day_8-2.rb

HEX_ESCAPE = /\\x[0-9abcdef]{2}/
ESCAPED_QUOTE = /\\"/
ESCAPED_SLASH = /\\{2}/

code_char_count = 0
encoded_char_count = 0

open(ARGV.shift).each_line{ |line|
	line = line.chomp[1..-2]
	code_char_count += 2
	encoded_char_count += 6

	while(true)
		case(line)
			when HEX_ESCAPE
				code_char_count += 4
				encoded_char_count += 5
				match = HEX_ESCAPE
			when ESCAPED_QUOTE
				code_char_count += 2
				encoded_char_count += 4
				match = ESCAPED_QUOTE
			when ESCAPED_SLASH
				code_char_count += 2
				encoded_char_count += 4
				match = ESCAPED_SLASH
			else
				break
		end
		
		line = line.sub(match, '')
	end
	
	code_char_count += line.length
	encoded_char_count += line.length
}

puts encoded_char_count - code_char_count
