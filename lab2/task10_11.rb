def input()
  return STDIN.gets.chomp()
end


def find_date(str)
  st = "\033[7m"
  en = "\033[m"
  return str.scan(/(?:[1-9]|[12][\d]|[3][01]) (?:декабря|января|февраля|марта|апреля|мая|июня|июля|августа|сентября|октября|ноября) (?:[1-9]{1}\d*)/)
end

def kirill(str)
  return str.scan(/[А-я]+/).sort_by{|el| el.size}.pop.size
end

def min_num(str)
  return str.scan(/\d+/).map{|el| el.to_i}.min
end

def max_count(str)
  return str.scan(/\d+/).sort_by{|el| el.size}.pop.size
end

puts "Выберите какое задание хотите решить."
puts "1 - найти все даты вида 00 месяц 0000"
puts "2 - найбольшее кол-во идущих подряд символов кириллицы"
puts "3 - найти минимальное из натуральных чисел в строке"
puts "4 - найти найбольшее количество идущих подряд цифр"

choose = input.to_i

case choose
when 1
  puts "Введите строку с датами"
  str = input
  puts find_date(str) 
when 2
  puts "Введите сроку с кириллицей"
  str = input
  puts kirill(str)
when 3
  puts "Введите строку с числами"
  str = input
  puts min_num(str)
when 4
  puts "Введите строку с цифрами"
  str = input
  puts max_count(str)
else
  puts "Вы че-то не то ввели. До свидания"
end