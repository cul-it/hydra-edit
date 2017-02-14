class Membership

 def makeMembers(id)
 
    coll = Collection.find("bolivian")
    coll.apply_depositor_metadata("jac244@cornell.edu")
    book = Book.find(id)
    book.apply_depositor_metadata("jac244@cornell.edu")
    book.member_of_collections << coll
    book.save
    puts id + " is now a member of Bolivian."
 end
end

lines = File.foreach('bolivianbookmembers.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
  maker = Membership.new()
  passid = "boli" + ARGV[0]
  maker.makeMembers(passid)
end
