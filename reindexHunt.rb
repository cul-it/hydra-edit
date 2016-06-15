b = Book.find(ARGV[0])
b.update_index
puts "Reindexed " + ARGV[0]
puts
