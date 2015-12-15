#day_12-1.rb

require 'json'

def process_element(element)
	case(element)
		when Integer
			element
		when Array
			element.map{ |ary_elem| process_element(ary_elem) }.inject(:+)
		when Hash
			element.values.map{ |hash_elem| process_element(hash_elem) }.inject(:+)
		else
			0
	end
end

input_json = JSON.parse(open(ARGV.shift).read)

puts process_element(input_json)
