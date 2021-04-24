def read_i()
  print "Введите массив чисел: "
  arr = STDIN.gets.chomp().split()
  return arr.map{|el| el.to_i}
end

def read_f()
  print "Введите массив чисел: "
  arr = STDIN.gets.chomp().split()
  return arr.map{|el| el.to_i}
end

def read_from_file(path)
  f = open path
  data = f.read
  f.close
  return data.split().map{|el| el.to_i}
end

#Дан целочесиленный массив, в котором лишь один элемент отличается от остальных. Найти его значение.
def method1(arr)
  return arr.select{|el| arr.count(el) == 1}
end

#Дан целочисленный массив. Необходимо найти два наименьших элемента.
def method2(arr)
  min1 = arr.min
  arr.delete(min1)
  min2 = arr.min
  return min1, min2
end

#Дано вещественное число R и массив вещественных чисел.
#Найти элемент массива, который наиболее близок к данному числу.
def method3(arr, r)
  tmp = arr.reduce([]){|new_arr, el| new_arr.push((el-r).abs)}
  i = tmp.index(tmp.min)
  return arr[i]
end

def method4()
  pass 
end

def method5()
  pass 
end

#if ARGV.length() < 2
#  puts "Ты за меня придурка не держи. Тут аргументов мало, 
#    надо два штука: первый - выбор решаемой задачи, 
#    второй - путь к файлу."
#end

choose = ARGV[0].to_i
#path = ARGV[1]



case choose
when 1
  arr = read_i()
  puts method1(arr)
when 2
  arr = read_i()
  puts method2(arr)
when 3
  arr = read_f()
  print "Введите вещественное число R: "
  r = STDIN.gets.chomp().to_f
  puts method3(arr, r)
when 4
  method4
when 5
  method5
end

