lines = File.foreach('findmissingmayBooks.txt')
lines.each do |line|
  puts line
  puts line.length
  
  line = line[0..-2]
  b = Book.find(line)
  puts b
  puts "has book " + line
  members = b.members
  if members.nil?
   puts "no members"
  else
   puts "has members"
  end
end
