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
path = ARGV[0]

arr = read_file(path)
#puts order_by_length(arr)
puts order_by_words_count(arr)
