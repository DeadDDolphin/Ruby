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
    new_arr << arr[i].to_i
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

def read_from_file(path)
  f = open path
  data = f.read
  f.close
  return data.split().map{|el| el.to_i}
end


if ARGV.length() < 2
  puts "Ты за меня придурка не держи. Тут аргументов мало,
    надо два штука: первый - выбор метода,
    второй - путь к файлу/размер массива."
end

choose = ARGV[0].to_i

if choose != 5
  size = ARGV[1].to_i
else
  path = ARGV[1]
end

case choose
when 1
  print(read1(size))
  print "\n"
when 2
  print(read2(size))
  print "\n"
when 3
  print(read3(size))
  print "\n"
when 4
  print(read4(size))
  print "\n"
when 5
  print(read_from_file(path))
  print "\n"
end
