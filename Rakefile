require 'pathname'
require 'fileutils'

root_dir = Pathname.pwd

root_dir.each_child do |dir|

#puts /Day\d+/ === dir.basename.to_s
	if dir.directory? && /Day\d+/ === dir.basename.to_s
		cur_day_folder = dir.basename
	
		namespace cur_day_folder.to_s.downcase do
			input_file = Pathname.glob("#{cur_day_folder}/*_input.txt").first
			next if input_file.nil?
		
			dir.each_child do |file|
				case(file.to_s)
					when /-1\.rb/
						desc "Runs Part 1 of #{cur_day_folder}"
						task :part1 do
							FileUtils.cd(dir)
							puts `ruby #{file} #{input_file.basename}`
							FileUtils.cd(root_dir)
						end
					when /-2\.rb/
						desc "Runs Part 2 of #{cur_day_folder}"
						task :part2 do
							FileUtils.cd(dir)
							puts `ruby #{file} #{input_file.basename}`
							FileUtils.cd(root_dir)
						end
					when /problem_description\.txt/
						desc "Prints out the #{cur_day_folder} Problem Description"
						task :problem do
							FileUtils.cd(dir)
							puts `cat problem_description.txt`
							FileUtils.cd(root_dir)
						end
				end
			end
		end
		
		task cur_day_folder.to_s.downcase => "#{cur_day_folder.to_s.downcase}:part1"
	end
end

desc "Sets up for the next Day's problem"
task :new_day do
	new_day = root_dir.each_child.map{ |dir| dir.basename.to_s.scan(/\d+/).last.to_i }.compact.max + 1
	new_day_folder = "Day#{new_day}"
	
	FileUtils.mkdir(new_day_folder)
	FileUtils.cd(new_day_folder)
	
	FileUtils.touch("day_#{new_day}-1.rb")
	FileUtils.touch("day_#{new_day}_input.txt")
	FileUtils.touch("problem_description.txt")
end
