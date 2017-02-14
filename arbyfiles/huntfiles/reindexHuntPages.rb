lines = File.foreach('huntbooks0082Forward.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
  b = Book.find(ARGV[0])
  extent = b.extent
  pages = extent[0].split(" ")
  count = pages[0].to_i
  puts "Saving pages for " + ARGV[0]
  for i in 1..count
    pageId = ARGV[0] + "_" + i.to_s
    p = Page.find(pageId)
    p.apply_depositor_metadata("jac244@cornell.edu")
    p.save
    #puts "Saved page " + i.to_s
  end
end
