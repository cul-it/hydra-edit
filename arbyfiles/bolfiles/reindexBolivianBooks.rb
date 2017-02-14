lines = File.foreach('bolivianbooks.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
  id = "boli" + ARGV[0]
  b = Book.find(id)
  b.apply_depositor_metadata("jac244@cornell.edu")
  b.save
  puts "reindexed id = " + id
end
