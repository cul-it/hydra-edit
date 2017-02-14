lines = File.foreach('reindexbolipages.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
  id = "boli" + ARGV[0]
  b = Book.find(id)
  extent = b.extent
  pages = extent[0].split(" ")
  count = pages[0].to_i
  puts
  puts "Saving pages for " + ARGV[0]
  for i in 1..count
    pageId = id + "_" + i.to_s
    p = Page.find(pageId)
    p.apply_depositor_metadata("jac244@cornell.edu")
    p.save
    #puts i.to_s
 end
end
