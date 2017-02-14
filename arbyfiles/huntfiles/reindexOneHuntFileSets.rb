lines = File.foreach('onehuntbook.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
  b = Book.find(ARGV[0])
  extent = b.extent
  pages = extent[0].split(" ")
  count = pages[0].to_i
  puts "Saving filesets for " + ARGV[0]
  for i in 1..count
    fsId = ARGV[0] + "_" + i.to_s + "_fs"
    fs = FileSet.find(fsId)
    fs.apply_depositor_metadata("jac244@cornell.edu")
    fs.save
    #puts "Saved page " + i.to_s
  end
end
