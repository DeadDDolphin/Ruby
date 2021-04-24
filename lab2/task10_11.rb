def input()
  return STDIN.gets.chomp()
end


def find_date(str)
  st = "\033[7m"
  en = "\033[m"
  return str.scan(/(?:[1-9]|[12][\d]|[3][01]) (?:декабря|января|февраля|марта|апреля|мая|июня|июля|августа|сентября|октября|ноября) (?:[1-9]{1}\d*)/)
end

puts "Выберите какое задание хотите решить."
puts "1 - найти все даты вида 00 месяц 0000"
puts "2 - "
puts "3 - "
puts "4 - "

choose = input.to_i

case choose
when 1
  str = input
  puts find_date(str) 
when 2
  pass
when 3
  pass
when 4
  pass
else
  puts "Вы че-то не то ввели. До свидания"
end