def read1(size)
  print "Введите массив чисел, #{size} штук: "
  return STDIN.gets.chomp().split().reduce([]){|arr, el| arr.push(el.to_i)}
end

def read2(size)
  print "Введите массив чисел, #{size} штук: "
  arr = STDIN.gets.chomp().split()
  new_arr = Array.new()
  for i in 0..size-1
    new_arr[i] = arr[i].to_i
  end
  return new_arr
end

def read3(size)
  print "Введите массив чисел, #{size} штук: "
  arr = STDIN.gets.chomp().split()
  new_arr = Array.new()
  for i in 0..size-1
    new_arr<<arr[i].to_i
  end
  return new_arr
end

def read4(size)
  print "Введите массив чисел, #{size} штук: "
  arr = STDIN.gets.chomp().split()
  new_arr = Array.new()
  for i in 1..size
    new_arr.unshift(arr[-i].to_i)
  end
  return new_arr
end

size = ARGV[0].to_i

print (read4(size))
print "\n"