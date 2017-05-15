lines = File.foreach("/users/jac244/rewroteMayY8.txt")
lines.each do |line|
 inputparam = line.chomp
 ARGV[0] = line.chomp
 if inputparam.include? '_fs'
   fileset = FileSet.find(inputparam)
   fileset.update_index
   puts "I should be saving a fileset"
 else
   testString = inputparam.split("_")
   if testString.size == 1
     book = Book.find(inputparam)
     puts book.title
     book.update_index
   puts "I should be saving a book"
   end
   if testString.size == 2
     page = Page.find(inputparam)
     page.update_index
   puts "I should be saving a page"
   end
 end
# puts inputparam
end

