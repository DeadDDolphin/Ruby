def read1(size)
  print "Введите массив чисел, #{size} штук: "
  return STDIN.gets.chomp().split().reduce([]){|arr, el| arr.push(el.to_i)}
end

size = ARGV[0].to_i

print (read1(size))
print "\n"