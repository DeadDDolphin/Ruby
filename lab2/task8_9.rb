def max_in_str(str)
  t = str.split()
  t.map{|el| el.to_i}
  return t.max
end

puts "Введите строку чисел через пробелы"
str = STDIN.gets.chomp()

puts "Max:" + max_in_str(str).to_s