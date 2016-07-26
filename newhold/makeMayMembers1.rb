c = Collection.find("maypamph")
c.apply_depositor_metadata("jac244@cornell.edu")
#a = c.members
pamphlets = []
File.open('maymovemaypamph1TOmaypamph.txt') do |f|
   f.each_line do |l|
     id = l.strip
     b = Book.find(id)
     b.apply_depositor_metadata("jac244@cornell.edu")
puts "Adding pamphlets to maypamph.members"
c.members << b
#c.save
#c.update_index
#     pamphlets << b
     puts "Adding " + id + " to pamphlets array"
   end
end
#File.close

