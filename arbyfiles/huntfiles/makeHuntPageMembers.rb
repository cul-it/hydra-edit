class Membership

 def makeMembers(id)
 
    book = Book.find(id)
    book.apply_depositor_metadata("jac244@cornell.edu")
    number = book.extent[0]
    number = number.gsub('p.','')
    puts "Number = " + number
    number = number.to_i
    variable_type = Integer
    i = 0
    if number.is_a?(variable_type)
      index = number.to_i
      puts "Index = " + index.to_s
      while i < index do
        i += 1
#        puts "in while loop"
        page_id = id + "_" + i.to_s
#        puts "Page = " + page_id
        print "."   
        page = Page.find(page_id)
        book.apply_depositor_metadata("jac244@cornell.edu")
        book.members << page
      end
    end
    book.save
    puts
    puts id + " now has " + i.to_s + " page members."
 end
end

lines = File.foreach('huntbookpagemembers.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
  maker = Membership.new()
  maker.makeMembers(ARGV[0])
end
