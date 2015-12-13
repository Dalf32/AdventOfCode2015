#day_7-2.rb

SIGNAL_MAX = 65535

def get_signal(wires, input)
	case input
		when /\d+/
			input.to_s.to_i
		else
			wires[input]
	end
end

def is_raw_input?(input)
	/\d+/ === input
end

def is_complete_signal?(wires, *inputs)
	return true if inputs.empty?
	inputs.all?{ |input| is_raw_input?(input) || wires.has_key?(input) }
end

def process_circuit(lines, wires)
	until lines.empty?
		lines_processed = []

		lines.each do |line|
			signal, out_wire = line.chomp.split(' -> ')
			inputs = []

			case(signal)
				when /AND/
					inputs = signal.split(' AND ').map(&:to_sym)
					value = get_signal(wires, inputs.first) & get_signal(wires, inputs.last)
				when /OR/
					inputs = signal.split(' OR ').map(&:to_sym)
					value = get_signal(wires, inputs.first) | get_signal(wires, inputs.last)
				when /LSHIFT/
					in_wire, shift = signal.split(' LSHIFT ')
					inputs << in_wire.to_sym
					value = get_signal(wires, in_wire.to_sym)<<shift.to_i
				when /RSHIFT/
					in_wire, shift = signal.split(' RSHIFT ')
					inputs << in_wire.to_sym
					value = get_signal(wires, in_wire.to_sym)>>shift.to_i
				when /NOT/
					in_wire = signal.gsub('NOT ', '')
					inputs << in_wire.to_sym
					value = ~get_signal(wires, in_wire.to_sym)
				else
					inputs << signal.to_sym
					value = get_signal(wires, signal.to_sym)
			end
			
			if is_complete_signal?(wires, *inputs)
				wires[out_wire.to_sym] = value < 0 ? SIGNAL_MAX + value + 1 : value
				lines_processed << line
			end
		end
		
		lines = lines - lines_processed
	end
end

file = ARGV.shift
wires = Hash.new(0)

lines = open(file).readlines
process_circuit(lines, wires)

lines = open(file).readlines
index = lines.find_index{ |line| line.chomp.end_with?(' -> b') }
lines[index] = "#{wires[:a]} -> b"
wires = Hash.new(0)
process_circuit(lines, wires)

puts wires[:a]
