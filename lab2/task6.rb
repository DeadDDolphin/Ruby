require 'prime'

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

#Для введенного списка положительных чисел построить 
#список всех положительных делителей элементов списка без повторений.
def divisors(n)
  return n if Prime.prime?(n)
  x = n
  arr = Array.new()
  until x == 1
    arr<<x if n%x == 0
    x-=1
  end
  return arr
end

def method4(arr)
  new_arr = arr.reduce([]){|new_arr, el| new_arr = new_arr.concat(divisors(el))}
  return new_arr.uniq.sort()
end

#Дан список. Построить новый список из квадратов неотрицательных
#чисел, меньших 100 и встречающихся в массиве больше 2 раз.
def method5(arr)
  new_arr = arr.reduce([]){|new_arr, el| new_arr << el**2 if el >= 0 and el < 100 and arr.count(el) > 2}
  return new_arr.uniq
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
  arr = read_i()
  puts method4(arr)
when 5
  arr = read_i()
  puts method5(arr)
end

