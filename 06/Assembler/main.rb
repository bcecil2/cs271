load "Assembler.rb"

def valid_args
	ARGV.size == 1 && File.extname(ARGV[0]) == ".asm" && File.exist?(ARGV[0])
end

if  valid_args
	asm_filename = ARGV[0]
	incoming_filename = File.basename(asm_filename, ".*")
	asm_path = File.dirname("#{asm_filename}")
	hack_file = "#{asm_path}\\#{incoming_filename}.hack"
	assembly_file = File.open("#{asm_filename}", "r")
	file_to_fill = File.open("#{hack_file}", "w")
	assembler = Assembler.new(ARGV[0])
	assembly_file.each do |line|
		assembler.first_pass(line)
	end

	assembly_file = File.open("#{asm_filename}", "r")
	assembly_file.each do |line|
		if !assembler.second_pass(line).empty? && assembler.Parser.command_type != "L"
		 file_to_fill << assembler.second_pass(line) << "\n"
		end
	end
		
else
	puts "call to main with invalid arguments"
end

