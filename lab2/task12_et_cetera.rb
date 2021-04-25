def read_file(path)
  f = open path
  arr=Array.new()
  f.each do |line|
    arr<<line
  end
  f.close
  return arr
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
path = ARGV[0]

arr = read_file(path)
#puts order_by_length(arr)
#puts order_by_words_count(arr)
#puts order_by_count_of_words_after_number(arr)
