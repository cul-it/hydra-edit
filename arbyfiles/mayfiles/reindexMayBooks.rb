lines = File.foreach('maybooks.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
  b = Book.find(ARGV[0])
  b.apply_depositor_metadata("jac244@cornell.edu")
  b.save
  puts "reindex id = " + ARGV[0]
end
