c = Collection.find("maypamph")
a = c.members
#pamphlets = []
File.open('mayfolders.txt') do |f|
   f.each_line do |l|
     id = l.strip
     b = Book.find(id)
     if a.include?(b)
       puts"Member" 
     else
        puts "Not a finga" + id
     end
   end
end
File.close

