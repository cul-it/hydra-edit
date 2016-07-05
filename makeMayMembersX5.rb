c = Collection.find("maypamph5")
c.apply_depositor_metadata("jac244@cornell.edu")
#a = c.members
pamphlets = []
count = 0
File.open('maytest.txt') do |f|
   f.each_line do |l|
     count = count + 1
     id = l.strip
     b = Book.find(id)
     b.apply_depositor_metadata("jac244@cornell.edu")
     puts "Adding " + id + " to pamphlets array"
     pamphlets << b
#     if count == 5
#       c.members << pamphlets
#       c.save
#       c.update_index
       #sleep(10)
#       puts "Resetting after count = " + count.to_s
#       pamphlets = []
#       count = 0
#     end
   end
end
#File.close
puts "Adding pamphlets to maypamph.members"
c.members << pamphlets
c.save
c.update_index

