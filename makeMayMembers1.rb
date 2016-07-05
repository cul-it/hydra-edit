c = Collection.find("maypamph")
c.apply_depositor_metadata("jac244@cornell.edu")
#a = c.members
pamphlets = []
File.open('mayAdd864516_864823.txt') do |f|
   f.each_line do |l|
     id = l.strip
     b = Book.find(id)
     b.apply_depositor_metadata("jac244@cornell.edu")
     pamphlets << b
     puts "Adding " + id + " to pamphlets array"
   end
end
#File.close
puts "Adding pamphlets to maypamph.members"
c.members << pamphlets
c.save
c.update_index

