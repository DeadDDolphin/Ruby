def read()
  print "Введите массив чисел: "
  arr = gets.chomp().split()
  return arr.map{|el| el.to_i}
end

def min(arr)
  return arr.min
end

def max(arr)
  return arr.max
end

def summ(arr)
  return arr.sum
end

def mult(arr)
  return arr.reduce(1){|k, el| k*=el}
end

arr = read
puts "Min:" + min(arr).to_s
puts "Max:" + max(arr).to_s
puts "Sum:" + summ(arr).to_s
puts "Mult:" + mult(arr).to_s