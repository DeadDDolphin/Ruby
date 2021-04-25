def read_file(path)
  f = open path
  arr=Array.new()
  f.each do |line|
    arr<<line
  end
  f.close
  return arr
end

def input()
  return STDIN.gets.chomp()
end


def order_by_length(arr)
   arr.sort_by{|el| el.size}
end

def order_by_words_count(arr)
  arr.sort_by{
    |str| str.scan(/[[:word:]]+/).length
  }
end

#АААААА, я не понимаю, как по мне, эти регулярки должны находить только слова, идущие после чисел. 
#А оно находит абсолютно всё, кроме пунктуации. 
#Я в бешенстве уже от этого, так что забью, успокоюсь, буду другое делать
def order_by_count_of_words_after_number(arr)
  arr.each do |str|
    print str[/[^\d+\s*[:word:]$]/]
    print "\n"
  end
  arr.sort_by{
   |str| str.scan(/[^\d+\s*[:word:]$]+/).length 
  }
end

def sort1(arr)
  #arr.each do |str|
  #  puts str.chars.map{|el| el.ord}.sum.to_f/str.chars.length.to_f
  #end
  arr.sort_by{
   |str| str.chars.map{|el| el.ord}.sum.to_f/str.chars.length.to_f
  }
end

#Я не понимаю словосочетания "выборки строк", поэтому буду сортировать просто по медиане каждой строки
#А так как это может быть любой символ, то сравниваться будет его код в ASCII
def mediana(arr)
  n = arr.length
  if n%2 == 0
    return (arr[n/2].ord + arr[n/2-1].ord).to_f/2.0
  end
  return arr[n/2].ord
end

def sort2(arr)
  arr.sort_by{
   |str| mediana(str.chars)
  }
end

path = ARGV[0]

arr = read_file(path)

puts "Выберите какое задание хотите решить."
puts "1 - сортировать в порядке увеличение среднего веса аски-кода символа строки"
puts "2 - в порядке увеличения медианного значения выборки строк"
puts "3 - в порядке увеличения квадратичного отклонения между наиболь-
шим ASCII-кодом символа строки и разницы в ASCII-кодах пар зеркально рас-
положенных символов строки"
puts "4 - в порядке увеличение квадратичного отклонения частоты встре-
чаемости самого распространенного символа в наборе строк от частоты его
встречаемости в данной строке"

choose = input.to_i

case choose
when 1
  puts sort1(arr)
when 2
  puts sort2(arr)
when 3
  pass
when 4
  pass
  puts "Вы че-то не то ввели. До свидания"
end

#puts order_by_length(arr)
#puts order_by_words_count(arr)
#puts order_by_count_of_words_after_number(arr)
