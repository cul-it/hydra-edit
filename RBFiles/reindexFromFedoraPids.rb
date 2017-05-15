lines = File.foreach("chlapids.txt")
lines.each do |line|
 inputparam = line.chomp
 ARGV[0] = line.chomp
 if inputparam.include? '_fs'
   fileset = FileSet.find(inputparam)
   fileset.update_index
   puts "I should be saving a fileset " + inputparam
 else
   testString = inputparam.split("_")
   if testString.size == 1
     book = Journal.find(inputparam)
     puts book.title
     book.update_index
   puts "I should be saving a Journal " + inputparam
   end
   if testString.size >= 2
     page = Issue.find(inputparam)
     page.update_index
   puts "I should be saving a Issue " + inputparam
   end
 end
# puts inputparam
end

