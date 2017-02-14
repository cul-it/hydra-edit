lines = File.foreach('onechlafilesets.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
  id = "chla" + ARGV[0]
  b = Book.find(id)
  extent = b.extent
  pages = extent[0].split(" ")
  count = pages[0].to_i
  puts
  puts "finding missing filesets for " + ARGV[0]
  for i in 1..count
    pageId = id + "_" + i.to_s + "_fs"
    p = FileSet.find(pageId)
  #  p.apply_depositor_metadata("jac244@cornell.edu")
  #  b.members << p
#    p.save
    puts i.to_s
  end
 # b.apply_depositor_metadata("jac244@cornell.edu")
 # b.save
  
end
