#day_8-1.rb

HEX_ESCAPE = /\\x[0-9abcdef]{2}/
ESCAPED_QUOTE = /\\"/
ESCAPED_SLASH = /\\{2}/

code_char_count = 0
memory_char_count = 0

open(ARGV.shift).each_line{ |line|
	line = line.chomp[1..-2]
	code_char_count += 2

	while(true)
		case(line)
			when HEX_ESCAPE
				code_char_count += 4
				match = HEX_ESCAPE
			when ESCAPED_QUOTE
				code_char_count += 2
				match = ESCAPED_QUOTE
			when ESCAPED_SLASH
				code_char_count += 2
				match = ESCAPED_SLASH
			else
				break
		end
		
		memory_char_count += 1
		line = line.sub(match, '')
	end
	
	code_char_count += line.length
	memory_char_count += line.length
}

puts code_char_count - memory_char_count
