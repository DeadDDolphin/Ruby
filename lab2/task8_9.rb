def input()
  return STDIN.gets.chomp()
end

def max_in_str(str)
  t = str.split()
  t.map{|el| el.to_i}
  return t.max
end

def permut(str)
  return str.chars.to_a.permutation.map{|el| el.join}.sample(1)
end

def palindr(str)
  s = str.delete "A-Z"
  return true if s == s.reverse
end

def order_words(str)
  t = str.scan(/[[:word:]]+/)
  t1 = t.reduce([]){|new_array, el| new_array<< el.size}
  t1.sort
  t2 = Array.new
  for i in 0..t1.length-1
    t2<< t[i]
  end
  return t2
end

puts "Выберите какое задание хотите решить."
puts "1 - максимум среди чисел"
puts "2 - перемешать все символы строки"
puts "3 - проверить являются ли прописные символы палиндромом"
puts "4 - упорядочить слова по количеству букв"

choose = input.to_i

case choose
when 1
  str = input
  puts "Max:" + max_in_str(str).to_s
when 2
  puts "Введите строку для перемешивания"
  str = input
  puts permut(str)
when 3
  puts "Введите строку для палиндромирования, алфавит латынский"
  str = input
  puts palindr(str)
when 4
  puts "Введите строку для упорядочивания слова по количеству букв"
  str = input
  puts order_words(str)
else
  puts "Вы че-то не то ввели. До свидания"
end
