lines = File.foreach('chlamonosmakepagemembers.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
  id = "chla" + ARGV[0]
  b = Book.find(id)
  extent = b.extent
  pages = extent[0].split(" ")
  count = pages[0].to_i
  puts
  puts "Adding page members for " + ARGV[0]
  for i in 1..count
    pageId = id + "_" + i.to_s
    p = Page.find(pageId)
    p.apply_depositor_metadata("jac244@cornell.edu")
    b.members << p
#    p.save
    #puts i.to_s
  end
  b.apply_depositor_metadata("jac244@cornell.edu")
  b.save
  
end
