require "awesome_print"

def read_from_file(path)
  f = open(path)
  n = f.gets.chomp
  m = f.gets.chomp
  f.reduce([]){|arr, line| arr << line.chomp.split(" ")}
end

def search_by(list, value)
  objects = []
  list.each do |el|
    if el == value
      objects << list.index(el)
      list[list.index(el)] = nil
    end
   end
   objects
end

def indexes_of_denied_objects(matr)
  matr.reduce([]) do |objects, list|
    objects << search_by(list, "*")
  end
end

def denied_objects(matr)
  l = indexes_of_denied_objects(matr)
  hash = l.flatten.each_with_object(Hash.new 0) {|el, counter| counter[el] +=1 }
  array = []
  hash.each{|el, count| array << el if matr.length == count}
  array
end

access_matr = read_from_file("InfBez/access_matr.txt")

ap denied_objects(access_matr)
