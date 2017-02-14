lines = File.foreach('chlabooks.txt')
lines.each do |line|
  inputparam = line.chomp
  ARGV[0] = line.chomp
  id = "chla" + ARGV[0]
  b = Book.find(id)
  b.apply_depositor_metadata("jac244@cornell.edu")
  b.save
end
