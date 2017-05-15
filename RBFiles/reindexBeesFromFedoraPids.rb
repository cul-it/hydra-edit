lines = File.foreach("/users/jac244/rewrotebeespidsFromFedora.txt")
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
     journal = Journal.find(inputparam)
     puts journal.title
     journal.update_index
   puts "I should be saving a journal"
   end
   if testString.size == 3
     issue = Issue.find(inputparam)
     issue.update_index
   puts "I should be saving an issue"
   end
   if testString.size == 4
     page = Page.find(inputparam)
     page.update_index
   puts "I should be saving a page"
   end
   if testString.size == 5
     articles = Article.find(inputparam)
     articles.update_index
   puts "I should be saving articles"
   end
 end
# puts inputparam
end

